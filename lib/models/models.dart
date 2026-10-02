import '../l10n/localized_string.dart';

class FriendStatus {
  const FriendStatus({
    required this.name,
    required this.status,
    required this.isTraining,
    this.streakDays = 7,
    this.exerciseIds = const [],
    this.handle = '',
    this.followingCount = 0,
    this.followersCount = 0,
    this.likesCount = 0,
    this.bio = const LocalizedString(en: '', am: '', om: ''),
  });

  final String name;
  final LocalizedString status;
  final bool isTraining;
  final int streakDays;
  final List<String> exerciseIds;
  final String handle;
  final int followingCount;
  final int followersCount;
  final int likesCount;
  final LocalizedString bio;
}

class FriendProfile {
  const FriendProfile({
    required this.status,
    required this.posts,
    required this.exercises,
    this.workouts = const [],
  });

  final FriendStatus status;
  final List<FeedPost> posts;
  final List<ExerciseItem> exercises;
  final List<FriendWorkoutSession> workouts;
}

class FriendWorkoutSet {
  const FriendWorkoutSet({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.weightKg,
  });

  final String exerciseId;
  final int sets;
  final int reps;
  final double weightKg;
}

class FriendWorkoutSession {
  const FriendWorkoutSession({
    required this.id,
    required this.friendName,
    required this.date,
    required this.title,
    required this.sets,
  });

  final String id;
  final String friendName;
  final DateTime date;
  final LocalizedString title;
  final List<FriendWorkoutSet> sets;
}

class ExerciseItem {
  ExerciseItem({
    required this.id,
    required this.name,
    required this.muscle,
    required this.type,
    required this.difficulty,
    required this.equipment,
    required this.instructions,
    required this.commonMistakes,
    required this.imageAsset,
    required this.youtubeVideoId,
    this.secondaryMuscles = const [],
  });

  final String id;
  final LocalizedString name;
  final LocalizedString muscle;
  final LocalizedString type;
  final LocalizedString difficulty;
  final LocalizedString equipment;
  final LocalizedString instructions;
  final LocalizedString commonMistakes;
  final String imageAsset;
  final String youtubeVideoId;
  final List<LocalizedString> secondaryMuscles;
}

class WorkoutExercise {
  const WorkoutExercise({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.weightKg,
    this.restSeconds = 90,
  });

  final ExerciseItem exercise;
  final int sets;
  final int reps;
  final double weightKg;
  final int restSeconds;
}

class WorkoutPlan {
  const WorkoutPlan({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.level,
    required this.muscles,
    required this.exercises,
    required this.owner,
    this.tag,
  });

  final String id;
  final LocalizedString title;
  final int durationMinutes;
  final LocalizedString level;
  final List<LocalizedString> muscles;
  final List<WorkoutExercise> exercises;
  final String owner;
  final LocalizedString? tag;
}

class GymPlace {
  const GymPlace({
    required this.id,
    required this.name,
    required this.distanceKm,
    required this.rating,
    required this.openUntil,
    required this.checkedInToday,
    required this.members,
    required this.activeThisWeek,
    required this.priceLabel,
    required this.amenities,
    required this.address,
  });

  final String id;
  final String name;
  final double distanceKm;
  final double rating;
  final LocalizedString openUntil;
  final int checkedInToday;
  final int members;
  final int activeThisWeek;
  final LocalizedString priceLabel;
  final List<LocalizedString> amenities;
  final LocalizedString address;
}

enum ProgressVisibility { privateOnly, friendsOnly, publicFeed }

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.name,
    required this.score,
    required this.isCurrentUser,
  });

  final String name;
  final int score;
  final bool isCurrentUser;
}

class ProgressMediaItem {
  const ProgressMediaItem({
    required this.kind,
    required this.label,
  });

  final ProgressMediaKind kind;
  final LocalizedString label;
}

enum ProgressMediaKind { photo, video }

class FeedPost {
  const FeedPost({
    required this.id,
    required this.author,
    required this.type,
    required this.body,
    required this.timeAgo,
    required this.reactions,
    this.meta,
    this.photoLabel,
    this.videoLabel,
    this.media = const [],
    this.weightKg,
    this.emotionEmoji,
    this.visibility = ProgressVisibility.publicFeed,
    this.viewerHasUpvoted = false,
    this.exerciseIds = const [],
    this.workoutSessionId,
    this.postedAt,
  });

  final String id;
  final String author;
  final LocalizedString type;
  final LocalizedString body;
  final LocalizedString timeAgo;
  final int reactions;
  final LocalizedString? meta;
  final LocalizedString? photoLabel;
  final LocalizedString? videoLabel;
  final List<ProgressMediaItem> media;
  final double? weightKg;
  final String? emotionEmoji;
  final ProgressVisibility visibility;
  final bool viewerHasUpvoted;
  final List<String> exerciseIds;
  final String? workoutSessionId;
  final DateTime? postedAt;

  List<ProgressMediaItem> get resolvedMedia {
    if (media.isNotEmpty) return media;
    return [
      if (photoLabel != null)
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: photoLabel!,
        ),
      if (videoLabel != null)
        ProgressMediaItem(
          kind: ProgressMediaKind.video,
          label: videoLabel!,
        ),
    ];
  }

  ProgressMediaItem? get primaryMedia =>
      resolvedMedia.isEmpty ? null : resolvedMedia.first;

  bool get hasPhoto =>
      resolvedMedia.any((m) => m.kind == ProgressMediaKind.photo);
  bool get hasVideo =>
      resolvedMedia.any((m) => m.kind == ProgressMediaKind.video);
  bool get hasMedia => resolvedMedia.isNotEmpty;
  int get upvoteCount => reactions;

  bool get isPrivate => visibility == ProgressVisibility.privateOnly;

  DateTime get effectivePostedAt => postedAt ?? DateTime.now();

  FeedPost copyWith({
    int? reactions,
    bool? viewerHasUpvoted,
    ProgressVisibility? visibility,
    List<String>? exerciseIds,
    String? workoutSessionId,
    DateTime? postedAt,
    List<ProgressMediaItem>? media,
  }) {
    return FeedPost(
      id: id,
      author: author,
      type: type,
      body: body,
      timeAgo: timeAgo,
      reactions: reactions ?? this.reactions,
      meta: meta,
      photoLabel: photoLabel,
      videoLabel: videoLabel,
      media: media ?? this.media,
      weightKg: weightKg,
      emotionEmoji: emotionEmoji,
      visibility: visibility ?? this.visibility,
      viewerHasUpvoted: viewerHasUpvoted ?? this.viewerHasUpvoted,
      exerciseIds: exerciseIds ?? this.exerciseIds,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      postedAt: postedAt ?? this.postedAt,
    );
  }
}

class ChallengeInfo {
  const ChallengeInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.goal,
    required this.daysLeft,
    required this.participants,
    required this.type,
    required this.typeLabel,
  });

  final String id;
  final LocalizedString title;
  final LocalizedString subtitle;
  final int progress;
  final int goal;
  final int daysLeft;
  final int participants;
  /// Stable English type key used for filtering (All/Personal/Friends/…).
  final String type;
  final LocalizedString typeLabel;
}

class TrainerProfile {
  const TrainerProfile({
    required this.id,
    required this.name,
    required this.specialization,
    required this.yearsExperience,
    required this.gym,
    required this.rating,
    required this.pricePerSessionEtb,
    required this.availability,
    required this.bio,
    required this.programs,
  });

  final String id;
  final String name;
  final LocalizedString specialization;
  final int yearsExperience;
  final String gym;
  final double rating;
  final int pricePerSessionEtb;
  final LocalizedString availability;
  final LocalizedString bio;
  final List<LocalizedString> programs;
}

class FitnessEvent {
  const FitnessEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.venue,
    required this.dateLabel,
    required this.timeLabel,
    required this.attending,
    required this.description,
  });

  final String id;
  final LocalizedString title;
  final LocalizedString type;
  final LocalizedString venue;
  final LocalizedString dateLabel;
  final LocalizedString timeLabel;
  final int attending;
  final LocalizedString description;
}

class ActivityEntry {
  const ActivityEntry({
    required this.title,
    required this.subtitle,
    required this.xp,
    required this.dateLabel,
  });

  final LocalizedString title;
  final LocalizedString subtitle;
  final int xp;
  final LocalizedString dateLabel;
}

enum ShopProductKind { protein, homeKit, accessory }

class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.title,
    required this.blurb,
    required this.priceEtb,
    required this.kind,
    required this.imageAsset,
    this.compareAtPriceEtb,
    this.discountPercent = 0,
    this.freeDelivery = true,
  });

  final String id;
  final LocalizedString title;
  final LocalizedString blurb;
  final int priceEtb;
  final ShopProductKind kind;
  final String imageAsset;

  /// Original price before discount; null if no sale.
  final int? compareAtPriceEtb;
  final int discountPercent;
  final bool freeDelivery;

  bool get hasDiscount =>
      discountPercent > 0 &&
      compareAtPriceEtb != null &&
      compareAtPriceEtb! > priceEtb;
}

enum ShopOrderStatus {
  paymentInitiated,
  paid,
  preparing,
  outForDelivery,
  delivered;

  static ShopOrderStatus? tryParse(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    for (final value in ShopOrderStatus.values) {
      if (value.name == raw) return value;
    }
    return null;
  }

  int get stepIndex => index;
}

class ShopOrder {
  const ShopOrder({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImageAsset,
    required this.priceEtb,
    required this.phone,
    required this.deliveryArea,
    required this.status,
    required this.createdAt,
    this.chapaRef,
  });

  final String id;
  final String productId;
  final String productTitle;
  final String productImageAsset;
  final int priceEtb;
  final String phone;
  final String deliveryArea;
  final ShopOrderStatus status;
  final DateTime createdAt;
  final String? chapaRef;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productTitle': productTitle,
        'productImageAsset': productImageAsset,
        'priceEtb': priceEtb,
        'phone': phone,
        'deliveryArea': deliveryArea,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'chapaRef': chapaRef,
      };

  factory ShopOrder.fromJson(Map<String, dynamic> json) {
    return ShopOrder(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productTitle: json['productTitle'] as String,
      productImageAsset: json['productImageAsset'] as String? ?? '',
      priceEtb: json['priceEtb'] as int,
      phone: json['phone'] as String,
      deliveryArea: json['deliveryArea'] as String,
      status: ShopOrderStatus.tryParse(json['status'] as String?) ??
          ShopOrderStatus.paid,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      chapaRef: json['chapaRef'] as String?,
    );
  }

  ShopOrder copyWith({ShopOrderStatus? status}) {
    return ShopOrder(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImageAsset: productImageAsset,
      priceEtb: priceEtb,
      phone: phone,
      deliveryArea: deliveryArea,
      status: status ?? this.status,
      createdAt: createdAt,
      chapaRef: chapaRef,
    );
  }
}
