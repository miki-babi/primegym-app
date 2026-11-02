import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'exercise_database.g.dart';

class LocalExercises extends Table {
  TextColumn get id => text()();
  TextColumn get externalId => text().withDefault(const Constant(''))();
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAm => text()();
  TextColumn get nameOm => text()();
  TextColumn get instructionsEn => text().nullable()();
  TextColumn get instructionsAm => text().nullable()();
  TextColumn get instructionsOm => text().nullable()();
  TextColumn get gifUrl => text().nullable()();
  TextColumn get gifLocalPath => text().nullable()();
  TextColumn get gifLocalUrl => text().nullable()();
  TextColumn get type => text()();
  TextColumn get difficulty => text()();
  TextColumn get status => text()();
  TextColumn get publishedAt => text().nullable()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalBodyParts extends Table {
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAm => text()();
  TextColumn get nameOm => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {slug};
}

class LocalMuscles extends Table {
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAm => text()();
  TextColumn get nameOm => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {slug};
}

class LocalEquipments extends Table {
  TextColumn get slug => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameAm => text()();
  TextColumn get nameOm => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {slug};
}

class LocalExerciseBodyParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text()();
  TextColumn get bodyPartSlug => text()();
}

class LocalExerciseMuscles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text()();
  TextColumn get muscleSlug => text()();
  TextColumn get role => text()();
}

class LocalExerciseEquipments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text()();
  TextColumn get equipmentSlug => text()();
}

class SyncMeta extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get lastSyncedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    LocalExercises,
    LocalBodyParts,
    LocalMuscles,
    LocalEquipments,
    LocalExerciseBodyParts,
    LocalExerciseMuscles,
    LocalExerciseEquipments,
    SyncMeta,
  ],
)
class ExerciseDatabase extends _$ExerciseDatabase {
  ExerciseDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            for (final table in allTables) {
              await m.drop(table);
            }
            await m.createAll();
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'primegym_exercises',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }

  Future<String?> getLastSyncedAt() async {
    final row = await (select(syncMeta)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    return row?.lastSyncedAt;
  }

  Future<void> setLastSyncedAt(String iso) async {
    await into(syncMeta).insertOnConflictUpdate(
      SyncMetaCompanion.insert(id: const Value(1), lastSyncedAt: Value(iso)),
    );
  }
}

Future<void> deleteQuietly(String? path) async {
  if (path == null || path.isEmpty) return;
  try {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  } catch (_) {}
}
