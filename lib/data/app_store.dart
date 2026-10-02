import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/localized_string.dart';
import '../models/models.dart';
import 'mock_data.dart';

class AppStore extends ChangeNotifier {
  AppStore._() {
    _feed = List.of(MockData.feed);
  }

  static final AppStore instance = AppStore._();

  static const _savedPlansPrefsKey = 'primegym_saved_workout_plans';

  late List<FeedPost> _feed;
  final Set<String> _savedWorkoutSessionIds = {};
  final Set<String> _savedWorkoutPlanIds = {};
  final Set<String> _followedFriends = {};

  List<FeedPost> get feed => List.unmodifiable(_feed);

  Set<String> get savedWorkoutPlanIds => Set.unmodifiable(_savedWorkoutPlanIds);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_savedPlansPrefsKey);
    if (stored == null || stored.isEmpty) return;
    instance._savedWorkoutPlanIds
      ..clear()
      ..addAll(stored);
  }

  Future<void> _persistSavedPlans() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _savedPlansPrefsKey,
      _savedWorkoutPlanIds.toList(growable: false),
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
      _savedWorkoutPlanIds.contains(workoutId);

  Future<bool> toggleSavedWorkoutPlan(String workoutId) async {
    final added = _savedWorkoutPlanIds.add(workoutId);
    if (!added) {
      _savedWorkoutPlanIds.remove(workoutId);
    }
    notifyListeners();
    await _persistSavedPlans();
    return added;
  }

  List<WorkoutPlan> savedWorkoutPlans() {
    return [
      for (final id in _savedWorkoutPlanIds)
        if (MockData.workoutById(id) != null) MockData.workoutById(id)!,
    ];
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
        if (MockData.exerciseById(id) != null) MockData.exerciseById(id)!,
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
