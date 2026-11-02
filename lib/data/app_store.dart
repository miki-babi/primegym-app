import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/localized_string.dart';
import '../models/models.dart';
import 'exercise_repository.dart';
import 'mock_data.dart';
import 'workout_catalog.dart';

class AppStore extends ChangeNotifier {
  AppStore._() {
    _feed = List.of(MockData.feed);
  }

  static final AppStore instance = AppStore._();

  static const _savedPlansPrefsKey = 'primegym_saved_workout_plans';
  static const _customCollectionsPrefsKey = 'primegym_custom_collections';

  late List<FeedPost> _feed;
  final Set<String> _savedWorkoutSessionIds = {};
  final Set<String> _savedWorkoutPlanIds = {};
  final Set<String> _followedFriends = {};
  /// In-session extras: workout plan id → exercise ids added from detail.
  final Map<String, List<String>> _exercisesAddedToPlans = {};
  /// User-created workout collections (persisted), newest first.
  final List<_CustomCollection> _customCollections = [];

  List<FeedPost> get feed => List.unmodifiable(_feed);

  Set<String> get savedWorkoutPlanIds => Set.unmodifiable(_savedWorkoutPlanIds);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_savedPlansPrefsKey);
    if (stored != null && stored.isNotEmpty) {
      instance._savedWorkoutPlanIds
        ..clear()
        ..addAll(stored);
    }
    final collectionsJson = prefs.getString(_customCollectionsPrefsKey);
    if (collectionsJson != null && collectionsJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(collectionsJson);
        if (decoded is List) {
          instance._customCollections
            ..clear()
            ..addAll([
              for (final entry in decoded)
                if (entry is Map<String, dynamic>)
                  _CustomCollection.fromJson(entry),
            ]);
        }
      } on FormatException {
        // Ignore corrupted persisted data.
      }
    }
  }

  Future<void> _persistSavedPlans() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _savedPlansPrefsKey,
      _savedWorkoutPlanIds.toList(growable: false),
    );
  }

  Future<void> _persistCustomCollections() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _customCollectionsPrefsKey,
      jsonEncode([
        for (final c in _customCollections) c.toJson(),
      ]),
    );
  }

  bool isWorkoutSaved(String sessionId) =>
      _savedWorkoutSessionIds.contains(sessionId);

  void saveWorkoutForLater(String sessionId) {
    if (_savedWorkoutSessionIds.add(sessionId)) {
      notifyListeners();
    }
  }

  void unsaveWorkoutForLater(String sessionId) {
    if (_savedWorkoutSessionIds.remove(sessionId)) {
      notifyListeners();
    }
  }

  bool isWorkoutPlanSaved(String workoutId) =>
      isCustomPlan(workoutId) || _savedWorkoutPlanIds.contains(workoutId);

  Future<bool> toggleSavedWorkoutPlan(String workoutId) async {
    if (isCustomPlan(workoutId)) return true;
    final added = _savedWorkoutPlanIds.add(workoutId);
    if (!added) {
      _savedWorkoutPlanIds.remove(workoutId);
    }
    notifyListeners();
    await _persistSavedPlans();
    return added;
  }

  bool isCustomPlan(String workoutId) =>
      _customCollections.any((c) => c.id == workoutId);

  /// Creates a persisted workout collection and returns its plan.
  WorkoutPlan createCollection(String name, {String? exerciseId}) {
    final collection = _CustomCollection(
      id: 'custom-${DateTime.now().microsecondsSinceEpoch}',
      name: name.trim(),
      exerciseIds: [
        if (exerciseId != null && exerciseId.isNotEmpty) exerciseId,
      ],
    );
    _customCollections.insert(0, collection);
    notifyListeners();
    unawaited(_persistCustomCollections());
    return _planForCollection(collection);
  }

  /// Resolves a workout plan by id, checking custom collections first.
  WorkoutPlan? workoutPlanById(String id) {
    for (final c in _customCollections) {
      if (c.id == id) return _planForCollection(c);
    }
    return MockData.workoutById(id);
  }

  WorkoutPlan _planForCollection(_CustomCollection collection) {
    final exercises = <WorkoutExercise>[];
    final seenMuscles = <String>{};
    final muscles = <LocalizedString>[];
    for (final id in collection.exerciseIds) {
      final item = ExerciseRepository.instance.exerciseById(id);
      if (item == null) continue;
      exercises.add(WorkoutCatalog.defaultExercisePrescription(item));
      if (seenMuscles.add(item.muscle.en)) muscles.add(item.muscle);
    }
    final name = collection.name;
    return WorkoutPlan(
      id: collection.id,
      title: LocalizedString(en: name, am: name, om: name),
      durationMinutes: exercises.isEmpty ? 10 : 5 + exercises.length * 5,
      level: const LocalizedString(en: 'Custom', am: 'ብጁ', om: 'Custom'),
      muscles: muscles,
      exercises: exercises,
      owner: MockData.currentUser,
    );
  }

  List<WorkoutPlan> savedWorkoutPlans() {
    return [
      for (final c in _customCollections) _planForCollection(c),
      for (final id in _savedWorkoutPlanIds)
        if (MockData.workoutById(id) != null) MockData.workoutById(id)!,
    ];
  }

  List<String> exercisesAddedToPlan(String workoutId) =>
      List.unmodifiable(_exercisesAddedToPlans[workoutId] ?? const []);

  bool recordExerciseAddedToPlan(String workoutId, String exerciseId) {
    if (workoutId.isEmpty || exerciseId.isEmpty) return false;
    for (final c in _customCollections) {
      if (c.id == workoutId) {
        if (c.exerciseIds.contains(exerciseId)) return false;
        c.exerciseIds.add(exerciseId);
        notifyListeners();
        unawaited(_persistCustomCollections());
        return true;
      }
    }
    final list = _exercisesAddedToPlans.putIfAbsent(workoutId, () => []);
    if (list.contains(exerciseId)) return false;
    list.add(exerciseId);
    notifyListeners();
    return true;
  }

  bool isFollowing(String name) => _followedFriends.contains(name);

  void toggleFollow(String name) {
    if (!_followedFriends.add(name)) {
      _followedFriends.remove(name);
    }
    notifyListeners();
  }

  Set<String> get friendNames =>
      MockData.friends.map((f) => f.name).toSet();

  bool isFriend(String name) => friendNames.contains(name);

  bool canViewerSee(FeedPost post) {
    if (post.author == MockData.currentUser) return true;
    switch (post.visibility) {
      case ProgressVisibility.privateOnly:
        return false;
      case ProgressVisibility.friendsOnly:
        return isFriend(post.author);
      case ProgressVisibility.publicFeed:
        return true;
    }
  }

  List<FeedPost> visibleFeed() =>
      _feed.where(canViewerSee).toList(growable: false);

  List<FeedPost> friendsProgressPosts() {
    return _feed
        .where(
          (p) =>
              isFriend(p.author) &&
              canViewerSee(p) &&
              (p.hasPhoto || p.hasVideo || p.emotionEmoji != null),
        )
        .toList(growable: false);
  }

  void addPost(FeedPost post) {
    _feed.insert(0, post);
    notifyListeners();
  }

  void toggleUpvote(String postId) {
    final index = _feed.indexWhere((p) => p.id == postId);
    if (index < 0) return;
    final post = _feed[index];
    final upvoted = !post.viewerHasUpvoted;
    _feed[index] = post.copyWith(
      viewerHasUpvoted: upvoted,
      reactions: (post.reactions + (upvoted ? 1 : -1)).clamp(0, 99999),
    );
    notifyListeners();
  }

  FeedPost? postById(String id) {
    for (final p in _feed) {
      if (p.id == id) return p;
    }
    return MockData.feedPostById(id);
  }

  FriendProfile? friendProfile(String name) {
    final status = MockData.friendByName(name) ??
        (name == MockData.currentUser
            ? FriendStatus(
                name: MockData.currentUser,
                status: const LocalizedString(
                  en: 'You',
                  am: 'እርስዎ',
                  om: 'Ati',
                ),
                isTraining: false,
                streakDays: MockData.streakDays,
                exerciseIds: const ['ex1', 'ex8', 'ex10'],
              )
            : null);
    if (status == null) return null;

    final posts = _feed
        .where((p) => p.author == name && canViewerSee(p))
        .toList()
      ..sort((a, b) => b.effectivePostedAt.compareTo(a.effectivePostedAt));

    final ids = <String>{
      ...status.exerciseIds,
      for (final p in posts) ...p.exerciseIds,
    };
    final exercises = [
      for (final id in ids)
        if (ExerciseRepository.instance.exerciseById(id) != null)
          ExerciseRepository.instance.exerciseById(id)!,
    ];

    return FriendProfile(
      status: status,
      posts: posts,
      exercises: exercises,
      workouts: MockData.workoutsForFriend(name),
    );
  }

  FriendWorkoutSession? sessionById(String id) =>
      MockData.workoutSessionById(id);

  List<FriendWorkoutSession> sessionsForFriend(String name) =>
      MockData.workoutsForFriend(name);

  List<LeaderboardEntry> leaderboardForChallenge(String challengeId) {
    final challenge =
        MockData.challengeById(challengeId) ?? MockData.challenges.first;
    final base = <LeaderboardEntry>[
      LeaderboardEntry(
        name: MockData.currentUser,
        score: challenge.progress,
        isCurrentUser: true,
      ),
      for (final friend in MockData.friends)
        LeaderboardEntry(
          name: friend.name,
          score: _friendChallengeScore(friend.name, challenge),
          isCurrentUser: false,
        ),
    ];

    // Boost current user slightly by total upvotes received on their posts.
    final userUpvotes = _feed
        .where((p) => p.author == MockData.currentUser)
        .fold(0, (sum, p) => sum + p.reactions);
    final boosted = [
      for (final e in base)
        if (e.isCurrentUser)
          LeaderboardEntry(
            name: e.name,
            score: e.score + (userUpvotes ~/ 10),
            isCurrentUser: true,
          )
        else
          e,
    ]..sort((a, b) => b.score.compareTo(a.score));
    return boosted;
  }

  int _friendChallengeScore(String name, ChallengeInfo challenge) {
    final hash = name.hashCode.abs();
    return ((hash % challenge.goal) + challenge.progress ~/ 2)
        .clamp(1, challenge.goal);
  }
}

/// Persisted user-created workout collection. Exercises are stored as ids and
/// resolved lazily against the exercise catalog when a plan is built.
class _CustomCollection {
  _CustomCollection({
    required this.id,
    required this.name,
    List<String>? exerciseIds,
  }) : exerciseIds = exerciseIds ?? [];

  final String id;
  final String name;
  final List<String> exerciseIds;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'exerciseIds': exerciseIds,
      };

  factory _CustomCollection.fromJson(Map<String, dynamic> json) {
    return _CustomCollection(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      exerciseIds: [
        for (final e in (json['exerciseIds'] as List? ?? const []))
          if (e is String) e,
      ],
    );
  }
}
