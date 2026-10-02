/// Muscle-grouped looping exercise demo videos under `assets/illustrations/`.
abstract final class ExerciseIllustrations {
  static const Map<String, List<String>> byFolder = {
    'abs': [
      'assets/illustrations/abs/abs_01.mp4',
      'assets/illustrations/abs/abs_02.mp4',
      'assets/illustrations/abs/abs_03.mp4',
      'assets/illustrations/abs/abs_04.mp4',
      'assets/illustrations/abs/abs_05.mp4',
      'assets/illustrations/abs/abs_06.mp4',
      'assets/illustrations/abs/abs_07.mp4',
      'assets/illustrations/abs/abs_08.mp4',
    ],
    'back': [
      'assets/illustrations/back/back_01.mp4',
      'assets/illustrations/back/back_02.mp4',
      'assets/illustrations/back/back_03.mp4',
      'assets/illustrations/back/back_04.mp4',
      'assets/illustrations/back/back_05.mp4',
      'assets/illustrations/back/back_06.mp4',
      'assets/illustrations/back/back_07.mp4',
      'assets/illustrations/back/back_08.mp4',
      'assets/illustrations/back/back_09.mp4',
      'assets/illustrations/back/back_10.mp4',
      'assets/illustrations/back/back_11.mp4',
      'assets/illustrations/back/back_12.mp4',
      'assets/illustrations/back/back_13.mp4',
    ],
    'biceps': [
      'assets/illustrations/biceps/biceps_01.mp4',
      'assets/illustrations/biceps/biceps_02.mp4',
      'assets/illustrations/biceps/biceps_03.mp4',
      'assets/illustrations/biceps/biceps_04.mp4',
      'assets/illustrations/biceps/biceps_05.mp4',
      'assets/illustrations/biceps/biceps_06.mp4',
      'assets/illustrations/biceps/biceps_07.mp4',
      'assets/illustrations/biceps/biceps_08.mp4',
    ],
    'calf': [
      'assets/illustrations/calf/calf_01.mp4',
      'assets/illustrations/calf/calf_02.mp4',
      'assets/illustrations/calf/calf_03.mp4',
    ],
    'chest': [
      'assets/illustrations/chest/chest_01.mp4',
      'assets/illustrations/chest/chest_02.mp4',
      'assets/illustrations/chest/chest_03.mp4',
      'assets/illustrations/chest/chest_04.mp4',
      'assets/illustrations/chest/chest_05.mp4',
      'assets/illustrations/chest/chest_06.mp4',
      'assets/illustrations/chest/chest_07.mp4',
      'assets/illustrations/chest/chest_08.mp4',
      'assets/illustrations/chest/chest_09.mp4',
      'assets/illustrations/chest/chest_10.mp4',
      'assets/illustrations/chest/chest_11.mp4',
      'assets/illustrations/chest/chest_12.mp4',
      'assets/illustrations/chest/chest_13.mp4',
      'assets/illustrations/chest/chest_14.mp4',
    ],
    'glute': [
      'assets/illustrations/glute/glute_01.mp4',
      'assets/illustrations/glute/glute_02.mp4',
    ],
    'legs': [
      'assets/illustrations/legs/legs_01.mp4',
      'assets/illustrations/legs/legs_02.mp4',
      'assets/illustrations/legs/legs_03.mp4',
      'assets/illustrations/legs/legs_04.mp4',
      'assets/illustrations/legs/legs_05.mp4',
      'assets/illustrations/legs/legs_06.mp4',
      'assets/illustrations/legs/legs_07.mp4',
    ],
    'neck': [
      'assets/illustrations/neck/neck_01.mp4',
      'assets/illustrations/neck/neck_02.mp4',
      'assets/illustrations/neck/neck_03.mp4',
    ],
    'shoulder': [
      'assets/illustrations/shoulder/shoulder_01.mp4',
      'assets/illustrations/shoulder/shoulder_02.mp4',
      'assets/illustrations/shoulder/shoulder_03.mp4',
      'assets/illustrations/shoulder/shoulder_04.mp4',
      'assets/illustrations/shoulder/shoulder_05.mp4',
      'assets/illustrations/shoulder/shoulder_06.mp4',
      'assets/illustrations/shoulder/shoulder_07.mp4',
      'assets/illustrations/shoulder/shoulder_08.mp4',
    ],
    'triceps': [
      'assets/illustrations/triceps/triceps_01.mp4',
      'assets/illustrations/triceps/triceps_02.mp4',
      'assets/illustrations/triceps/triceps_03.mp4',
      'assets/illustrations/triceps/triceps_04.mp4',
      'assets/illustrations/triceps/triceps_05.mp4',
      'assets/illustrations/triceps/triceps_06.mp4',
      'assets/illustrations/triceps/triceps_07.mp4',
      'assets/illustrations/triceps/triceps_08.mp4',
    ],
  };

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
