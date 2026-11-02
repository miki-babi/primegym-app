import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// In-memory active workout session so progress survives leaving the screen.
class ActiveWorkoutController extends ChangeNotifier {
  ActiveWorkoutController._();
  static final ActiveWorkoutController instance = ActiveWorkoutController._();

  String? _workoutId;
  int _exerciseIndex = 0;
  int _setIndex = 0;
  double _weight = 0;
  int _reps = 0;
  double _sessionWeightSum = 0;
  double _lastCompletedWeightSum = 0;
  final List<String> _queuedExerciseIds = [];
  bool _notifyScheduled = false;

  bool get isActive => _workoutId != null;
  String? get workoutId => _workoutId;
  int get exerciseIndex => _exerciseIndex;
  int get setIndex => _setIndex;
  double get weight => _weight;
  int get reps => _reps;
  /// Sum of weights logged on completed sets in the active session.
  double get sessionWeightSum => _sessionWeightSum;
  /// Weight sum from the most recently finished workout (survives [clear]).
  double get lastCompletedWeightSum => _lastCompletedWeightSum;
  List<String> get queuedExerciseIds =>
      List.unmodifiable(_queuedExerciseIds);

  String? get resumeLocation =>
      _workoutId == null ? null : '/workout/$_workoutId/active';

  bool isSessionFor(String workoutId) =>
      isActive && _workoutId == workoutId;

  void start({
    required String workoutId,
    required double weight,
    required int reps,
  }) {
    _workoutId = workoutId;
    _exerciseIndex = 0;
    _setIndex = 0;
    _weight = weight;
    _reps = reps;
    _sessionWeightSum = 0;
    _queuedExerciseIds.clear();
    _safeNotify();
  }

  /// Adds the weight used for a completed set to the session total.
  void recordCompletedSetWeight(double weightKg) {
    if (!isActive) return;
    _sessionWeightSum += weightKg;
    _safeNotify();
  }

  /// Append an exercise to the active session (shown after plan exercises).
  bool queueExercise(String exerciseId) {
    if (!isActive || exerciseId.isEmpty) return false;
    if (_queuedExerciseIds.contains(exerciseId)) return false;
    _queuedExerciseIds.add(exerciseId);
    _safeNotify();
    return true;
  }

  void sync({
    required int exerciseIndex,
    required int setIndex,
    required double weight,
    required int reps,
  }) {
    if (!isActive) return;
    _exerciseIndex = exerciseIndex;
    _setIndex = setIndex;
    _weight = weight;
    _reps = reps;
    _safeNotify();
  }

  void clear() {
    if (!isActive && _queuedExerciseIds.isEmpty) return;
    _lastCompletedWeightSum = _sessionWeightSum;
    _workoutId = null;
    _exerciseIndex = 0;
    _setIndex = 0;
    _weight = 0;
    _reps = 0;
    _sessionWeightSum = 0;
    _queuedExerciseIds.clear();
    _safeNotify();
  }

  /// Avoids setState-during-build when start/clear run from initState.
  void _safeNotify() {
    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      notifyListeners();
      return;
    }
    if (_notifyScheduled) return;
    _notifyScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyScheduled = false;
      notifyListeners();
    });
  }
}
