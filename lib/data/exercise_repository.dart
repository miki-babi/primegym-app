import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import 'api/exercise_api_models.dart';
import 'api/exercise_media_downloader.dart';
import 'api/exercises_api.dart';
import 'local/exercise_database.dart';
import 'user_preferences.dart';
import 'workout_catalog.dart';

class ExerciseRepository extends ChangeNotifier {
  ExerciseRepository({
    ExerciseDatabase? database,
    ExercisesApi? api,
    ExerciseMediaDownloader? downloader,
    Connectivity? connectivity,
    this.isOnline,
  })  : _db = database ?? ExerciseDatabase(),
        _api = api ?? ExercisesApi(),
        _downloader = downloader ?? ExerciseMediaDownloader(),
        _connectivity = connectivity ?? Connectivity();

  final ExerciseDatabase _db;
  final ExercisesApi _api;
  final ExerciseMediaDownloader _downloader;
  final Connectivity _connectivity;
  final Future<bool> Function()? isOnline;

  List<ExerciseItem> _exercises = [];
  bool _loading = false;
  String? _lastError;
  bool _initialized = false;

  List<ExerciseItem> get exercises => List.unmodifiable(_exercises);
  bool get loading => _loading;
  String? get lastError => _lastError;
  bool get hasLocalCatalog => _exercises.isNotEmpty;

  static ExerciseRepository? _instance;
  static ExerciseRepository get instance =>
      _instance ??= ExerciseRepository();

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await refreshFromLocal();
    unawaited(
      syncIfOnline().catchError((Object error) {
        debugPrint('Exercise sync failed: $error');
        return false;
      }),
    );
  }

  Future<void> refreshFromLocal() async {
    final rows = await _db.select(_db.localExercises).get();
    if (rows.isEmpty) {
      _exercises = const [];
      notifyListeners();
      return;
    }

    final muscles = {
      for (final m in await _db.select(_db.localMuscles).get()) m.slug: m,
    };
    final equipments = {
      for (final e in await _db.select(_db.localEquipments).get()) e.slug: e,
    };
    final bodyPartLinks = await _db.select(_db.localExerciseBodyParts).get();
    final muscleLinks = await _db.select(_db.localExerciseMuscles).get();
    final equipmentLinks =
        await _db.select(_db.localExerciseEquipments).get();

    final items = <ExerciseItem>[];
    for (final row in rows) {
      items.add(_mapExercise(
        row,
        muscles: muscles,
        equipments: equipments,
        bodyPartLinks:
            bodyPartLinks.where((l) => l.exerciseId == row.id).toList(),
        muscleLinks:
            muscleLinks.where((l) => l.exerciseId == row.id).toList(),
        equipmentLinks:
            equipmentLinks.where((l) => l.exerciseId == row.id).toList(),
      ));
    }
    _exercises = items;
    notifyListeners();
  }

  ExerciseItem? exerciseById(String id) {
    for (final exercise in _exercises) {
      if (exercise.id == id) return exercise;
    }
    final mockMatch = RegExp(r'^ex(\d+)$').firstMatch(id);
    if (mockMatch != null && _exercises.isNotEmpty) {
      final n = int.parse(mockMatch.group(1)!);
      return _exercises[(n - 1) % _exercises.length];
    }
    return null;
  }

  List<ExerciseItem> exercisesForEnvironments(Set<TrainingEnvironment> envs) {
    return _exercises
        .where((e) => exerciseMatchesEnvironments(e, envs))
        .toList();
  }

  Future<bool> syncIfOnline({bool force = false}) async {
    final online = isOnline != null ? await isOnline!() : await _checkOnline();
    if (!online) return false;

    _loading = true;
    _lastError = null;
    notifyListeners();

    try {
      final since = force ? null : await _db.getLastSyncedAt();
      final isFullSync = since == null;
      final dtos = await _api.fetchExercises(since: since);

      try {
        await _refreshTaxonomies();
      } catch (error) {
        debugPrint('Taxonomy sync failed: $error');
      }

      for (final dto in dtos) {
        await _upsertExercise(dto);
      }

      if (isFullSync) {
        final remoteIds = dtos.map((d) => d.id).toSet();
        final localIds = (await _db.select(_db.localExercises).get())
            .map((r) => r.id)
            .toList();
        for (final id in localIds) {
          if (!remoteIds.contains(id)) {
            await _removeExercise(id);
          }
        }
      }

      if (dtos.isNotEmpty) {
        String? latest;
        DateTime? latestParsed;
        for (final dto in dtos) {
          final parsed = DateTime.tryParse(dto.updatedAt);
          if (latest == null ||
              (parsed != null &&
                  (latestParsed == null || parsed.isAfter(latestParsed)))) {
            latest = dto.updatedAt;
            latestParsed = parsed;
          }
        }
        if (latest != null) {
          await _db.setLastSyncedAt(latest);
        }
      }

      await refreshFromLocal();
    } catch (error, stack) {
      debugPrint('Exercise sync failed: $error\n$stack');
      _lastError = error.toString();
      notifyListeners();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }

    try {
      await _downloadPendingGifs();
    } catch (error) {
      debugPrint('Gif download pass failed: $error');
    }
    return true;
  }

  Future<void> _downloadPendingGifs() async {
    final rows = await _db.select(_db.localExercises).get();
    final pending = rows
        .where((r) =>
            r.gifUrl != null &&
            r.gifUrl!.isNotEmpty &&
            (r.gifLocalPath == null || r.gifLocalUrl != r.gifUrl))
        .toList();
    if (pending.isEmpty) return;

    var downloaded = 0;
    for (final row in pending) {
      try {
        final path = await _downloader.download(
          exerciseId: row.id,
          url: row.gifUrl!,
          fileName: 'animation${_extensionFor(row.gifUrl!)}',
        );
        await (_db.update(_db.localExercises)
              ..where((t) => t.id.equals(row.id)))
            .write(
          LocalExercisesCompanion(
            gifLocalPath: Value(path),
            gifLocalUrl: Value(row.gifUrl!),
          ),
        );
      } catch (error) {
        debugPrint('Gif download failed for ${row.id}: $error');
      }
      downloaded++;
      if (downloaded % 5 == 0) {
        await refreshFromLocal();
      }
    }
    await refreshFromLocal();
  }

  Future<bool> _checkOnline() async {
    final results = await _connectivity.checkConnectivity();
    return !results.every((r) => r == ConnectivityResult.none);
  }

  Future<void> _refreshTaxonomies() async {
    final bodyParts = await _api.fetchBodyParts();
    for (final item in bodyParts) {
      await _db.into(_db.localBodyParts).insertOnConflictUpdate(
            LocalBodyPartsCompanion.insert(
              slug: item.slug,
              nameEn: item.nameEn,
              nameAm: item.nameAm,
              nameOm: item.nameOm,
              sortOrder: Value(item.sortOrder),
            ),
          );
    }

    final muscles = await _api.fetchMuscles();
    for (final item in muscles) {
      await _db.into(_db.localMuscles).insertOnConflictUpdate(
            LocalMusclesCompanion.insert(
              slug: item.slug,
              nameEn: item.nameEn,
              nameAm: item.nameAm,
              nameOm: item.nameOm,
              sortOrder: Value(item.sortOrder),
            ),
          );
    }

    final equipments = await _api.fetchEquipments();
    for (final item in equipments) {
      await _db.into(_db.localEquipments).insertOnConflictUpdate(
            LocalEquipmentsCompanion.insert(
              slug: item.slug,
              nameEn: item.nameEn,
              nameAm: item.nameAm,
              nameOm: item.nameOm,
              sortOrder: Value(item.sortOrder),
            ),
          );
    }
  }

  Future<void> _removeExercise(String id) async {
    final exercise = await (_db.select(_db.localExercises)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    await deleteQuietly(exercise?.gifLocalPath);
    await _downloader.deleteExerciseDir(id);

    await (_db.delete(_db.localExerciseBodyParts)
          ..where((t) => t.exerciseId.equals(id)))
        .go();
    await (_db.delete(_db.localExerciseMuscles)
          ..where((t) => t.exerciseId.equals(id)))
        .go();
    await (_db.delete(_db.localExerciseEquipments)
          ..where((t) => t.exerciseId.equals(id)))
        .go();
    await (_db.delete(_db.localExercises)..where((t) => t.id.equals(id))).go();
  }

  Future<void> _upsertExercise(ExerciseDto dto) async {
    final existing = await (_db.select(_db.localExercises)
          ..where((t) => t.id.equals(dto.id)))
        .getSingleOrNull();

    String? gifLocal = existing?.gifLocalPath;
    String? gifLocalUrl = existing?.gifLocalUrl;
    if (dto.gifUrl == null || dto.gifUrl!.isEmpty) {
      await deleteQuietly(gifLocal);
      gifLocal = null;
      gifLocalUrl = null;
    }

    await _db.into(_db.localExercises).insertOnConflictUpdate(
          LocalExercisesCompanion.insert(
            id: dto.id,
            externalId: Value(dto.externalId),
            slug: dto.slug,
            nameEn: dto.nameEn,
            nameAm: dto.nameAm,
            nameOm: dto.nameOm,
            instructionsEn: Value(dto.instructionsEn),
            instructionsAm: Value(dto.instructionsAm),
            instructionsOm: Value(dto.instructionsOm),
            gifUrl: Value(dto.gifUrl),
            gifLocalPath: Value(gifLocal),
            gifLocalUrl: Value(gifLocalUrl),
            type: dto.type,
            difficulty: dto.difficulty,
            status: dto.status,
            publishedAt: Value(dto.publishedAt),
            updatedAt: dto.updatedAt,
          ),
        );

    for (final ref in dto.bodyParts) {
      await _db.into(_db.localBodyParts).insert(
            LocalBodyPartsCompanion.insert(
              slug: ref.slug,
              nameEn: ref.nameEn,
              nameAm: ref.nameAm,
              nameOm: ref.nameOm,
            ),
            onConflict: DoUpdate(
              (old) => LocalBodyPartsCompanion(
                nameEn: Value(ref.nameEn),
                nameAm: Value(ref.nameAm),
                nameOm: Value(ref.nameOm),
              ),
            ),
          );
    }
    await (_db.delete(_db.localExerciseBodyParts)
          ..where((t) => t.exerciseId.equals(dto.id)))
        .go();
    for (final ref in dto.bodyParts) {
      await _db.into(_db.localExerciseBodyParts).insert(
            LocalExerciseBodyPartsCompanion.insert(
              exerciseId: dto.id,
              bodyPartSlug: ref.slug,
            ),
          );
    }

    for (final ref in dto.muscles) {
      await _db.into(_db.localMuscles).insert(
            LocalMusclesCompanion.insert(
              slug: ref.slug,
              nameEn: ref.nameEn,
              nameAm: ref.nameAm,
              nameOm: ref.nameOm,
            ),
            onConflict: DoUpdate(
              (old) => LocalMusclesCompanion(
                nameEn: Value(ref.nameEn),
                nameAm: Value(ref.nameAm),
                nameOm: Value(ref.nameOm),
              ),
            ),
          );
    }
    await (_db.delete(_db.localExerciseMuscles)
          ..where((t) => t.exerciseId.equals(dto.id)))
        .go();
    for (final ref in dto.muscles) {
      await _db.into(_db.localExerciseMuscles).insert(
            LocalExerciseMusclesCompanion.insert(
              exerciseId: dto.id,
              muscleSlug: ref.slug,
              role: ref.role,
            ),
          );
    }

    for (final ref in dto.equipments) {
      await _db.into(_db.localEquipments).insert(
            LocalEquipmentsCompanion.insert(
              slug: ref.slug,
              nameEn: ref.nameEn,
              nameAm: ref.nameAm,
              nameOm: ref.nameOm,
            ),
            onConflict: DoUpdate(
              (old) => LocalEquipmentsCompanion(
                nameEn: Value(ref.nameEn),
                nameAm: Value(ref.nameAm),
                nameOm: Value(ref.nameOm),
              ),
            ),
          );
    }
    await (_db.delete(_db.localExerciseEquipments)
          ..where((t) => t.exerciseId.equals(dto.id)))
        .go();
    for (final ref in dto.equipments) {
      await _db.into(_db.localExerciseEquipments).insert(
            LocalExerciseEquipmentsCompanion.insert(
              exerciseId: dto.id,
              equipmentSlug: ref.slug,
            ),
          );
    }
  }

  static const _placeholderImage =
      'assets/images/exercise/photo_1@14-02-2025_15-21-56.jpg';

  static const _bodyweightLabel = LocalizedString(
      en: 'Bodyweight', am: 'የሰውነት ክብደት', om: 'Ulfaatina qaamaa');

  LocalizedString _equipmentLabel(
    String? slug,
    LocalEquipment? equipment,
  ) {
    switch (slug) {
      case null:
        return _bodyweightLabel;
      case 'body-weight':
      case 'assisted':
        return _bodyweightLabel;
      case 'dumbbell':
        return const LocalizedString(
            en: 'Dumbbells', am: 'ዳምቤሎች', om: 'Daambeloota');
      case 'barbell':
      case 'olympic-barbell':
      case 'ez-barbell':
        return const LocalizedString(
            en: 'Barbell', am: 'ባርቤል', om: 'Baarbeelii');
      case 'cable':
        return const LocalizedString(
            en: 'Cable', am: 'ኬብል', om: 'Keebilii');
      default:
        if (equipment != null) {
          return LocalizedString(
            en: _title(equipment.nameEn),
            am: _title(equipment.nameAm),
            om: _title(equipment.nameOm),
          );
        }
        return LocalizedString(en: _title(slug), am: _title(slug), om: _title(slug));
    }
  }

  ExerciseItem _mapExercise(
    LocalExercise row, {
    required Map<String, LocalMuscle> muscles,
    required Map<String, LocalEquipment> equipments,
    required List<LocalExerciseBodyPart> bodyPartLinks,
    required List<LocalExerciseMuscle> muscleLinks,
    required List<LocalExerciseEquipment> equipmentLinks,
  }) {
    LocalizedString titleCased(String? en, String? am, String? om) {
      final enName = en ?? '';
      return LocalizedString(
        en: _title(enName),
        am: _title(am ?? enName),
        om: _title(om ?? enName),
      );
    }

    final primaryLinks =
        muscleLinks.where((m) => m.role == 'primary').toList();
    final secondaryLinks =
        muscleLinks.where((m) => m.role == 'secondary').toList();

    LocalizedString muscleName(String slug) {
      final muscle = muscles[slug];
      if (muscle == null) {
        final label = _title(slug);
        return LocalizedString(en: label, am: label, om: label);
      }
      return titleCased(muscle.nameEn, muscle.nameAm, muscle.nameOm);
    }

    final primaryMuscle = primaryLinks.isNotEmpty
        ? muscleName(primaryLinks.first.muscleSlug)
        : const LocalizedString(
            en: 'Full body', am: 'ሙሉ አካል', om: 'Qaama guutuu');

    final secondaryMuscles = <LocalizedString>[
      for (final link in secondaryLinks) muscleName(link.muscleSlug),
    ];

    final equipmentSlug =
        equipmentLinks.isNotEmpty ? equipmentLinks.first.equipmentSlug : null;
    final equipmentLabel =
        _equipmentLabel(equipmentSlug, equipments[equipmentSlug]);

    return ExerciseItem(
      id: row.id,
      name: titleCased(row.nameEn, row.nameAm, row.nameOm),
      muscle: primaryMuscle,
      type: LocalizedString(
        en: _title(row.type),
        am: _title(row.type),
        om: _title(row.type),
      ),
      difficulty: LocalizedString(
        en: _title(row.difficulty),
        am: _title(row.difficulty),
        om: _title(row.difficulty),
      ),
      equipment: equipmentLabel,
      instructions: LocalizedString(
        en: row.instructionsEn ?? '',
        am: row.instructionsAm ?? '',
        om: row.instructionsOm ?? '',
      ),
      commonMistakes: const LocalizedString(en: '', am: '', om: ''),
      imageAsset: row.gifLocalPath ?? _placeholderImage,
      youtubeVideoId: '',
      secondaryMuscles: secondaryMuscles,
      animationPath: row.gifLocalPath ?? row.gifUrl,
      imageIsFile: row.gifLocalPath != null,
      animationIsFile: row.gifLocalPath != null,
      bodyPartSlugs: [
        for (final link in bodyPartLinks) link.bodyPartSlug,
      ],
      primaryMuscleSlug:
          primaryLinks.isNotEmpty ? primaryLinks.first.muscleSlug : null,
      equipmentSlug: equipmentSlug,
    );
  }

  String _title(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  String _extensionFor(String url) {
    final uri = Uri.tryParse(url);
    final name = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : url;
    final dot = name.lastIndexOf('.');
    if (dot == -1) return '';
    final ext = name.substring(dot);
    if (ext.length > 5) return '';
    return ext;
  }
}
