import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primegym/data/api/exercise_api_models.dart';
import 'package:primegym/data/api/exercise_media_downloader.dart';
import 'package:primegym/data/api/exercises_api.dart';
import 'package:primegym/data/exercise_repository.dart';
import 'package:primegym/data/local/exercise_database.dart';

class FakeExercisesApi extends ExercisesApi {
  List<ExerciseDto> next = [];
  String? lastSince;
  int fetchExercisesCalls = 0;

  @override
  Future<List<ExerciseDto>> fetchExercises({String? since}) async {
    fetchExercisesCalls++;
    lastSince = since;
    return next;
  }

  @override
  Future<List<TaxonomyItemDto>> fetchBodyParts() async => [];

  @override
  Future<List<TaxonomyItemDto>> fetchMuscles() async => [];

  @override
  Future<List<TaxonomyItemDto>> fetchEquipments() async => [];
}

class FakeDownloader extends ExerciseMediaDownloader {
  int downloadCalls = 0;
  final List<String> deletedDirs = [];

  @override
  Future<String?> download({
    required String exerciseId,
    required String url,
    required String fileName,
  }) async {
    downloadCalls++;
    return '/fake/$exerciseId/$fileName';
  }

  @override
  Future<void> deleteExerciseDir(String exerciseId) async {
    deletedDirs.add(exerciseId);
  }
}

ExerciseDto exercise(
  String id,
  String name,
  String updatedAt, {
  String? gifUrl = 'https://example.com/gif.gif',
}) {
  return ExerciseDto(
    id: id,
    externalId: id,
    slug: id,
    nameEn: name,
    nameAm: name,
    nameOm: name,
    instructionsEn: 'do it',
    gifUrl: gifUrl,
    type: 'compound',
    difficulty: 'beginner',
    status: 'published',
    publishedAt: '2026-01-01T00:00:00Z',
    updatedAt: updatedAt,
    bodyParts: [
      TaxonomyRefDto(
          slug: 'legs', nameEn: 'legs', nameAm: 'legs-am', nameOm: 'legs-om'),
    ],
    muscles: [
      MuscleRefDto(
          slug: 'quads',
          nameEn: 'quads',
          nameAm: 'quads-am',
          nameOm: 'quads-om',
          role: 'primary'),
      MuscleRefDto(
          slug: 'calves',
          nameEn: 'calves',
          nameAm: 'calves-am',
          nameOm: 'calves-om',
          role: 'secondary'),
    ],
    equipments: [
      TaxonomyRefDto(
          slug: 'barbell',
          nameEn: 'barbell',
          nameAm: 'barbell-am',
          nameOm: 'barbell-om'),
    ],
  );
}

void main() {
  late ExerciseDatabase db;
  late FakeExercisesApi api;
  late FakeDownloader downloader;
  late ExerciseRepository repo;

  setUp(() {
    db = ExerciseDatabase(NativeDatabase.memory());
    api = FakeExercisesApi();
    downloader = FakeDownloader();
    repo = ExerciseRepository(
      database: db,
      api: api,
      downloader: downloader,
      isOnline: () async => true,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('full sync inserts exercises and maps fields', () async {
    api.next = [
      exercise('a', 'squat', '2026-01-01T00:00:00Z'),
      exercise('b', 'lunge', '2026-01-02T00:00:00Z'),
    ];

    expect(await repo.syncIfOnline(), isTrue);
    await repo.refreshFromLocal();

    expect(api.lastSince, isNull);
    expect(repo.exercises.length, 2);

    final squat = repo.exercises.firstWhere((e) => e.id == 'a');
    expect(squat.name.en, 'Squat');
    expect(squat.muscle.en, 'Quads');
    expect(squat.secondaryMuscles.map((m) => m.en), ['Calves']);
    expect(squat.equipment.en, 'Barbell');
    expect(squat.animationPath, '/fake/a/animation.gif');
    expect(squat.animationIsFile, isTrue);
    expect(squat.imageIsFile, isTrue);
    expect(squat.bodyPartSlugs, ['legs']);
    expect(squat.primaryMuscleSlug, 'quads');
    expect(squat.equipmentSlug, 'barbell');

    expect(await db.getLastSyncedAt(), '2026-01-02T00:00:00Z');
    expect(downloader.downloadCalls, 2);
  });

  test('incremental sync passes since and keeps untouched exercises', () async {
    api.next = [
      exercise('a', 'squat', '2026-01-01T00:00:00Z'),
      exercise('b', 'lunge', '2026-01-02T00:00:00Z'),
    ];
    await repo.syncIfOnline();

    api.next = [exercise('a', 'squat', '2026-01-03T00:00:00Z')];
    expect(await repo.syncIfOnline(), isTrue);
    await repo.refreshFromLocal();

    expect(api.lastSince, '2026-01-02T00:00:00Z');
    expect(repo.exercises.map((e) => e.id).toSet(), {'a', 'b'});
    expect(await db.getLastSyncedAt(), '2026-01-03T00:00:00Z');
  });

  test('forced full sync deletes exercises missing from the response',
      () async {
    api.next = [
      exercise('a', 'squat', '2026-01-01T00:00:00Z'),
      exercise('b', 'lunge', '2026-01-02T00:00:00Z'),
    ];
    await repo.syncIfOnline();

    api.next = [exercise('a', 'squat', '2026-01-01T00:00:00Z')];
    expect(await repo.syncIfOnline(force: true), isTrue);
    await repo.refreshFromLocal();

    expect(api.lastSince, isNull);
    expect(repo.exercises.map((e) => e.id).toList(), ['a']);
    expect(downloader.deletedDirs, contains('b'));
  });

  test('re-sync with same updated_at does not re-download the gif', () async {
    api.next = [exercise('a', 'squat', '2026-01-01T00:00:00Z')];
    await repo.syncIfOnline();
    expect(downloader.downloadCalls, 1);

    api.next = [exercise('a', 'squat', '2026-01-01T00:00:00Z')];
    await repo.syncIfOnline();
    expect(downloader.downloadCalls, 1);
  });
}
