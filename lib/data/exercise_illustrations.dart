/// Muscle-grouped looping exercise demo videos under `assets/illustrations/`.
///
/// Bundled illustration MP4s were removed from the repo; paths stay empty so
/// callers fall back to API/downloaded [animationPath] or static images.
abstract final class ExerciseIllustrations {
  static const Map<String, List<String>> byFolder = {};

  static String? folderForMuscle(String muscleEn) {
    return switch (muscleEn) {
      'Chest' => 'chest',
      'Back' => 'back',
      'Triceps' => 'triceps',
      'Shoulders' => 'shoulder',
      'Arms' => 'biceps',
      'Legs' => 'legs',
      'Core' => 'abs',
      _ => null,
    };
  }

  /// Stable pick within the muscle folder for [id], or null if unmapped/empty.
  static String? forExercise(String id, String muscleEn) {
    final folder = folderForMuscle(muscleEn);
    if (folder == null) return null;
    final paths = byFolder[folder];
    if (paths == null || paths.isEmpty) return null;
    return paths[id.hashCode.abs() % paths.length];
  }
}
