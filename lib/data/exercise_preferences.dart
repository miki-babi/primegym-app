enum ExerciseFeedback { liked, disliked }

enum SkipReason { tooHard, noEquipment, injured, didntLike, other }

/// In-memory demo preferences — resets when the app restarts.
abstract final class ExercisePreferences {
  static final Map<String, ExerciseFeedback> _byExercise = {};
  static final List<String> _sessionSkippedExerciseIds = [];
  static final Map<String, SkipReason> _skipReasonsByExerciseId = {};

  static ExerciseFeedback? feedbackFor(String exerciseId) =>
      _byExercise[exerciseId];

  static void setFeedback(String exerciseId, ExerciseFeedback feedback) {
    _byExercise[exerciseId] = feedback;
  }

  static void clearFeedback(String exerciseId) {
    _byExercise.remove(exerciseId);
  }

  static bool get hasAnyFeedback => _byExercise.isNotEmpty;

  static Set<String> get likedMuscles {
    // Resolved lazily by callers that have exercise catalog access.
    return {};
  }

  static Iterable<MapEntry<String, ExerciseFeedback>> get entries =>
      _byExercise.entries;

  static Set<String> likedExerciseIds() => _byExercise.entries
      .where((e) => e.value == ExerciseFeedback.liked)
      .map((e) => e.key)
      .toSet();

  static Set<String> dislikedExerciseIds() => _byExercise.entries
      .where((e) => e.value == ExerciseFeedback.disliked)
      .map((e) => e.key)
      .toSet();

  static List<String> get sessionSkippedExerciseIds =>
      List.unmodifiable(_sessionSkippedExerciseIds);

  static bool get hasSessionSkips => _sessionSkippedExerciseIds.isNotEmpty;

  static void recordSessionSkip(String exerciseId) {
    if (!_sessionSkippedExerciseIds.contains(exerciseId)) {
      _sessionSkippedExerciseIds.add(exerciseId);
    }
  }

  static void clearSessionSkips() {
    _sessionSkippedExerciseIds.clear();
  }

  static SkipReason? skipReasonFor(String exerciseId) =>
      _skipReasonsByExerciseId[exerciseId];

  static Map<String, SkipReason> get skipReasonsByExerciseId =>
      Map.unmodifiable(_skipReasonsByExerciseId);

  static void setSkipReason(String exerciseId, SkipReason reason) {
    _skipReasonsByExerciseId[exerciseId] = reason;
    _byExercise[exerciseId] = ExerciseFeedback.disliked;
  }

  static void clearSkipReasons() {
    _skipReasonsByExerciseId.clear();
  }
}
