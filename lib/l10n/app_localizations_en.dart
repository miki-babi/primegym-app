// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navExplore => 'Explore';

  @override
  String get navCommunity => 'Community';

  @override
  String get navActivity => 'Activity';

  @override
  String get navProfile => 'Profile';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingEnterHome => 'Enter home';

  @override
  String get onboardingChooseLanguageTitle => 'Choose your language';

  @override
  String get onboardingChooseLanguageSubtitle =>
      'You can change this anytime in settings.';

  @override
  String get onboardingEquipmentTitle => 'Where will you train?';

  @override
  String get onboardingEquipmentSubtitle =>
      'Pick one or more places — we\'ll tailor exercises to your gear.';

  @override
  String get equipmentNoEquipment => 'No equipment';

  @override
  String get equipmentNoEquipmentDesc => 'Bodyweight workouts, anywhere';

  @override
  String get equipmentNoEquipmentDetail =>
      'Train with just your body — push-ups, squats, planks, and core work. Ideal for travel, parks, or zero-gear days.';

  @override
  String get equipmentNoEquipmentHighlight1 => 'Bodyweight only';

  @override
  String get equipmentNoEquipmentHighlight2 => 'Train anywhere';

  @override
  String get equipmentNoEquipmentHighlight3 => 'No gear needed';

  @override
  String get equipmentHome => 'Home';

  @override
  String get equipmentHomeDesc => 'Dumbbells, bands, or home equipment';

  @override
  String get equipmentHomeDetail =>
      'Use dumbbells, bands, or whatever you keep at home. We\'ll skip gym machines and cables so every move fits your space.';

  @override
  String get equipmentHomeHighlight1 => 'Dumbbells';

  @override
  String get equipmentHomeHighlight2 => 'Bands';

  @override
  String get equipmentHomeHighlight3 => 'Home gear';

  @override
  String get equipmentGym => 'Gym';

  @override
  String get equipmentGymDesc =>
      'Machines, barbells, cables, and full equipment';

  @override
  String get equipmentGymDetail =>
      'Full access to machines, barbells, cables, and racks. Get complete strength plans built for a real gym floor.';

  @override
  String get equipmentGymHighlight1 => 'Machines';

  @override
  String get equipmentGymHighlight2 => 'Barbells';

  @override
  String get equipmentGymHighlight3 => 'Cables';

  @override
  String get settingsTrainingEnvironment => 'Training environment';

  @override
  String get onboardingWelcomeHeadline => 'Welcome to';

  @override
  String get onboardingWelcomeAccent => 'PrimeGym';

  @override
  String get onboardingWelcomeBody =>
      'Train smarter, eat better, and grow with community across Addis.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageAmharic => 'አማርኛ (Amharic)';

  @override
  String get languageAfaanOromoo => 'Afaan Oromoo';

  @override
  String get goalBuildMuscle => 'Build muscle';

  @override
  String get goalLoseFat => 'Lose fat';

  @override
  String get goalGainWeight => 'Gain weight';

  @override
  String get goalMaintain => 'Maintain';

  @override
  String get goalImproveStrength => 'Improve strength';

  @override
  String get goalImproveFitness => 'Improve fitness';

  @override
  String get goalImproveEndurance => 'Improve endurance';

  @override
  String get goalGeneralHealth => 'General health';

  @override
  String get levelBeginner => 'Beginner';

  @override
  String get levelIntermediate => 'Intermediate';

  @override
  String get levelAdvanced => 'Advanced';

  @override
  String get onboardingPlanTitle => 'You\'re ready to train';

  @override
  String get onboardingPlanSubtitle =>
      'Here\'s your personalized PrimeGym setup.';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String greetingWithName(String greeting, String name) {
    return '$greeting, $name 👋';
  }

  @override
  String dayStreak(int count) {
    return '$count-day streak';
  }

  @override
  String get sectionToday => 'Today';

  @override
  String get workoutProgressZeroOfOne => '0 of 1 workout';

  @override
  String get startWorkout => 'Start workout';

  @override
  String get sectionQuickActions => 'Quick actions';

  @override
  String get quickActionWorkout => 'Workout';

  @override
  String get quickActionFindGym => 'Find gym';

  @override
  String get quickActionCheckIn => 'Check in';

  @override
  String get exploreWorkouts => 'Explore workouts';

  @override
  String get savedWorkouts => 'Saved workouts';

  @override
  String get popularWorkouts => 'Popular workouts';

  @override
  String get filterTargetMuscle => 'Target muscle';

  @override
  String get filterAvailableEquipment => 'Available equipment';

  @override
  String get equipmentBodyweight => 'Bodyweight';

  @override
  String get equipmentDumbbells => 'Dumbbells';

  @override
  String get equipmentBarbell => 'Barbell';

  @override
  String get equipmentCable => 'Cable';

  @override
  String get noWorkoutsMatchFilters => 'No workouts match these filters.';

  @override
  String namedMuscleWorkout(String name, String muscles) {
    return '$name $muscles workout';
  }

  @override
  String workoutDurationExercises(int minutes, String exercises) {
    return '$minutes min · $exercises';
  }

  @override
  String get sectionYourFriends => 'Your friends';

  @override
  String get actionSeeCommunity => 'See community';

  @override
  String get sectionThisWeek => 'This week';

  @override
  String get weekStatWorkout => 'Workouts';

  @override
  String get labelStreak => 'Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String get sectionNearYou => 'Near you';

  @override
  String get nearYouGyms => 'Gyms';

  @override
  String get nearYouEvents => 'Events';

  @override
  String get exploreTitle => 'Explore';

  @override
  String get searchDemoOnlyForNow => 'Search is demo-only for now';

  @override
  String get exploreSearchHint => 'Search gyms, workouts…';

  @override
  String get sectionNearby => 'Nearby';

  @override
  String get categoryGyms => 'Gyms';

  @override
  String get categoryTrainers => 'Trainers';

  @override
  String get categoryEvents => 'Events';

  @override
  String get categoryShop => 'Shop';

  @override
  String get categoryChallenges => 'Challenges';

  @override
  String get categoryCommunities => 'Communities';

  @override
  String get sectionShop => 'Shop';

  @override
  String get shopSeeAll => 'See all';

  @override
  String get order => 'Order';

  @override
  String orderPlacedDemo(String product) {
    return 'Order placed for $product (demo)';
  }

  @override
  String shopHeadlineProtein(String name) {
    return '$name, we picked the best protein for you';
  }

  @override
  String shopHeadlineDelivery(String area) {
    return 'Free delivery to $area';
  }

  @override
  String get shopHeadlineNoEquipment =>
      'Train at home — all-in-one kit for you';

  @override
  String shopPriceEtb(String price) {
    return '$price ETB';
  }

  @override
  String shopDiscountPercent(int percent) {
    return '-$percent%';
  }

  @override
  String shopFreeDeliveryTo(String area) {
    return 'Free delivery to $area';
  }

  @override
  String shopDeliverTo(String area) {
    return 'Deliver to $area';
  }

  @override
  String get shopForYouBadge => 'For you';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get checkoutPayWithTelebirr => 'Telebirr';

  @override
  String get checkoutPayingTelebirr => 'Opening…';

  @override
  String get checkoutPayManually => 'Manual';

  @override
  String get checkoutManualTitle => 'Manual payment';

  @override
  String get checkoutManualIntro =>
      'Follow these steps, then confirm once you’ve paid.';

  @override
  String get checkoutManualStep1 => 'Open your Telebirr or bank app';

  @override
  String checkoutManualStep2(String amount) {
    return 'Send $amount to PrimeGym Merchant (1000 2345 6789)';
  }

  @override
  String checkoutManualStep3(String code) {
    return 'Use your order note: PG-$code';
  }

  @override
  String get checkoutManualStep4 => 'Keep the SMS receipt until delivery';

  @override
  String get checkoutManualConfirm => 'I’ve paid';

  @override
  String get checkoutPoweredByChapa => 'Secure checkout via Chapa (demo)';

  @override
  String checkoutDeliverTo(String area) {
    return 'Deliver to $area';
  }

  @override
  String get checkoutProductMissing => 'Product not found';

  @override
  String get checkoutIncludes => 'What’s included';

  @override
  String get checkoutFreeDeliveryBadge => 'Free delivery';

  @override
  String get checkoutSecurePay => 'Secure payment';

  @override
  String get myOrders => 'My orders';

  @override
  String get trackOrder => 'Track order';

  @override
  String get ordersEmptyTitle => 'No orders yet';

  @override
  String get ordersEmptyBody =>
      'Order something from the shop and track it here.';

  @override
  String get browseShop => 'Browse shop';

  @override
  String get orderDetailTitle => 'Order';

  @override
  String orderChapaRef(String ref) {
    return 'Chapa ref · $ref';
  }

  @override
  String orderContactPhone(String phone) {
    return 'Contact · $phone';
  }

  @override
  String get orderStatusPaymentInitiated => 'Payment initiated';

  @override
  String get orderStatusPaid => 'Paid';

  @override
  String get orderStatusPreparing => 'Preparing';

  @override
  String get orderStatusOutForDelivery => 'Out for delivery';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderTrackingTitle => 'Tracking';

  @override
  String get paymentSuccessTitle => 'Payment successful';

  @override
  String get paymentSuccessBody =>
      'Your order is confirmed. You can track delivery anytime.';

  @override
  String get sectionPopularExercises => 'Popular exercises';

  @override
  String get sectionRecommendedWorkouts => 'Recommended workouts';

  @override
  String workoutDurationLevel(int minutes, String level) {
    return '$minutes min · $level';
  }

  @override
  String get sectionTrendingInAddis => 'Trending in Addis';

  @override
  String checkedInTodayCount(num rating, int count) {
    return '$rating ★ · $count checked in today';
  }

  @override
  String get trainersTitle => 'Trainers';

  @override
  String get searchDemoOnly => 'Search is demo-only';

  @override
  String get searchTrainersHint => 'Search trainers…';

  @override
  String trainerPricePerSession(num rating, String price) {
    return '$rating ★ · $price / session';
  }

  @override
  String get trainerDetailTitle => 'Trainer';

  @override
  String get follow => 'Follow';

  @override
  String followingDemo(String name) {
    return 'Following $name (demo)';
  }

  @override
  String get statRating => 'Rating';

  @override
  String get statYears => 'Years';

  @override
  String get statSession => 'Session';

  @override
  String get sectionPrograms => 'Programs';

  @override
  String get bookDemo => 'Book (demo)';

  @override
  String get bookingDemoOnly => 'Booking is demo-only';

  @override
  String get eventsTitle => 'Events';

  @override
  String eventAttendingMeta(String time, int count) {
    return '$time · $count attending';
  }

  @override
  String get eventDetailTitle => 'Event';

  @override
  String attendingCount(int count) {
    return '$count attending';
  }

  @override
  String get sectionAbout => 'About';

  @override
  String get joinEventDemo => 'Join event (demo)';

  @override
  String get joinedEventDemo => 'Joined event (demo)';

  @override
  String get challengesTitle => 'Challenges';

  @override
  String get noChallengesInFilter => 'No challenges in this filter';

  @override
  String challengeProgressMeta(
    int progress,
    int goal,
    int days,
    int participants,
  ) {
    return '$progress/$goal · $days days left · $participants people';
  }

  @override
  String get addedToFavoritesDemo => 'Added to favorites (demo)';

  @override
  String equipmentLabel(String equipment) {
    return 'Equipment: $equipment';
  }

  @override
  String secondaryMusclesLabel(String muscles) {
    return 'Secondary: $muscles';
  }

  @override
  String get instructionsTitle => 'Instructions';

  @override
  String get commonMistakesTitle => 'Common mistakes';

  @override
  String get exerciseVideoTitle => 'Video';

  @override
  String get addToWorkout => 'Add to workout';

  @override
  String get addedToWorkoutDemo => 'Added to workout (demo)';

  @override
  String get gymsNearYou => 'Gyms near you';

  @override
  String distanceKm(num distance) {
    return '$distance km';
  }

  @override
  String gymOpenUntilRating(num rating, String time) {
    return '$rating ★ · Open until $time';
  }

  @override
  String peopleCheckedInToday(int count) {
    return '$count people checked in today';
  }

  @override
  String gymDistanceAway(num rating, num distance) {
    return '$rating ★ · $distance km away';
  }

  @override
  String get sectionInformation => 'Information';

  @override
  String get infoHours => 'Hours';

  @override
  String openUntil(String time) {
    return 'Open until $time';
  }

  @override
  String get infoMembership => 'Membership';

  @override
  String get infoLocation => 'Location';

  @override
  String get infoAmenities => 'Amenities';

  @override
  String get sectionCommunity => 'Community';

  @override
  String gymCommunitySuffix(String name) {
    return '$name community';
  }

  @override
  String membersCount(int count) {
    return '$count members';
  }

  @override
  String activeThisWeek(int count) {
    return '$count active this week';
  }

  @override
  String get septemberChallenge => 'September challenge';

  @override
  String get joinCommunity => 'Join community';

  @override
  String get joinedCommunityDemo => 'Joined community (demo)';

  @override
  String get checkIn => 'Check in';

  @override
  String get checkedIn => 'Checked in';

  @override
  String checkInXpPeople(int count) {
    return '+25 XP · $count people here';
  }

  @override
  String get done => 'Done';

  @override
  String get startWorkoutTitle => 'Start workout';

  @override
  String get todaysSuggestion => 'Today\'s suggestion';

  @override
  String get recommendedForYou => 'Recommended for you';

  @override
  String exercisesCount(int count) {
    return '$count exercises';
  }

  @override
  String get startTodaysPlan => 'Start today\'s plan';

  @override
  String get orTrainSomethingElse => 'Or train something else';

  @override
  String get noWorkoutsForFilter => 'No workouts for this filter';

  @override
  String get basedOnYou => 'Based on you';

  @override
  String workoutDurationMuscles(int minutes, String muscles) {
    return '$minutes min · $muscles';
  }

  @override
  String get workoutTitle => 'Workout';

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String exercisesCountCapitalized(int count) {
    return '$count Exercises';
  }

  @override
  String setsTimesReps(int sets, String reps) {
    return '$sets × $reps';
  }

  @override
  String setsTimesRepsWithWeight(int sets, String reps, String weight) {
    return '$sets × $reps · $weight';
  }

  @override
  String get suggestMoreLikeThis => 'Suggest more like this';

  @override
  String get showThisLess => 'Show this less';

  @override
  String exerciseProgress(int current, int total) {
    return 'Exercise $current of $total';
  }

  @override
  String get finish => 'Finish';

  @override
  String get skipExercise => 'Skip exercise';

  @override
  String get whyDidYouSkip => 'Why did you skip?';

  @override
  String get skipFeedback => 'Skip';

  @override
  String get skipReasonTooHard => 'Too hard';

  @override
  String get skipReasonNoEquipment => 'No equipment';

  @override
  String get skipReasonInjured => 'Injured / pain';

  @override
  String get skipReasonDidntLike => 'Didn\'t like it';

  @override
  String get skipReasonOther => 'Other';

  @override
  String setProgress(int current, int total) {
    return 'Set $current of $total';
  }

  @override
  String weightTimesReps(String weight, String reps) {
    return '$weight × $reps';
  }

  @override
  String previousSet(String weight, String reps) {
    return 'Previous: $weight × $reps';
  }

  @override
  String weightKg(num weight) {
    return '$weight kg';
  }

  @override
  String get labelWeight => 'Weight';

  @override
  String get labelReps => 'Reps';

  @override
  String get nice => 'Nice!';

  @override
  String get completeSet => 'Complete set';

  @override
  String get workoutComplete => 'Workout complete!';

  @override
  String minutesCount(int minutes) {
    return '$minutes minutes';
  }

  @override
  String exercisesAndSets(int exercises, int sets) {
    return '$exercises exercises · $sets sets';
  }

  @override
  String xpGain(int xp) {
    return '+$xp XP';
  }

  @override
  String streakMaintained(int days) {
    return '$days-day streak maintained';
  }

  @override
  String get personalizationUpdatedDemo => 'Personalization updated (demo)';

  @override
  String get share => 'Share';

  @override
  String get sharedToCommunityDemo => 'Shared to community (demo)';

  @override
  String get wizardSwipeBackHint => 'Swipe right anytime to go back';

  @override
  String get wizardSwipeBothHint => 'Swipe left to continue · right to go back';

  @override
  String get wizardSwipeBackOnlyHint => 'Swipe right to go back';

  @override
  String get viewDetails => 'View details';

  @override
  String get savedAsPrivateProgress => 'Saved as private progress';

  @override
  String get progressPostedToFeed => 'Progress posted to feed';

  @override
  String get communityTitle => 'Community';

  @override
  String get postProgress => 'Post progress';

  @override
  String get activeChallenges => 'Active challenges';

  @override
  String challengeDaysLeftShort(int progress, int goal, int days) {
    return '$progress/$goal · ${days}d left';
  }

  @override
  String get sectionFeed => 'Feed';

  @override
  String get privateBadge => 'Private';

  @override
  String get cheer => 'Cheer';

  @override
  String weightKgLabel(num weight) {
    return '$weight kg';
  }

  @override
  String get challengeTitle => 'Challenge';

  @override
  String daysLeft(int days) {
    return '$days days left';
  }

  @override
  String participantsCount(int count) {
    return '$count participants';
  }

  @override
  String get viewLeaderboardDemo => 'View leaderboard (demo)';

  @override
  String get leaderboardDemoOnly => 'Leaderboard is demo-only';

  @override
  String get emotionFiredUp => 'Fired up';

  @override
  String get emotionStrong => 'Strong';

  @override
  String get emotionHappy => 'Happy';

  @override
  String get emotionCalm => 'Calm';

  @override
  String get emotionDetermined => 'Determined';

  @override
  String get emotionProud => 'Proud';

  @override
  String get pickHowYouFeel => 'Pick how you feel';

  @override
  String get enterValidWeightKg => 'Enter a valid weight in kg';

  @override
  String feelingEmotionToday(String emotion) {
    return 'Feeling $emotion today';
  }

  @override
  String get feedTypeProgress => 'Progress';

  @override
  String get justNow => 'Just now';

  @override
  String get postProgressTitle => 'Post progress';

  @override
  String get photoSection => 'Photo';

  @override
  String get tapToChangePhotoDemo => 'Tap to change photo (demo)';

  @override
  String get howDoYouFeel => 'How do you feel?';

  @override
  String get weightOptional => 'Weight (optional)';

  @override
  String get weightHint => 'e.g. 72.5';

  @override
  String get unitKg => 'kg';

  @override
  String get captionOptional => 'Caption (optional)';

  @override
  String get captionHint => 'Share a note about your session…';

  @override
  String get makePrivate => 'Make private';

  @override
  String get privateOnlyYou => 'Only you can see this';

  @override
  String get visibleOnFeed => 'Visible on your community feed';

  @override
  String get postPrivately => 'Post privately';

  @override
  String get visibilityLabel => 'Who can see this';

  @override
  String get visibilityPrivate => 'Private';

  @override
  String get visibilityFriends => 'Friends';

  @override
  String get visibilityPublic => 'Public';

  @override
  String get visibilityPrivateHint => 'Only you can see this';

  @override
  String get visibilityFriendsHint => 'Visible to your friends';

  @override
  String get visibilityPublicHint => 'Visible on the community feed';

  @override
  String get friendsOnlyBadge => 'Friends';

  @override
  String get publicBadge => 'Public';

  @override
  String get savedAsFriendsProgress => 'Shared with friends';

  @override
  String get sectionFriendsProgress => 'Friends\' progress';

  @override
  String get mediaTypeLabel => 'Media';

  @override
  String get mediaPhoto => 'Photo';

  @override
  String get mediaVideo => 'Video';

  @override
  String get videoSection => 'Video';

  @override
  String get tapToChangeVideoDemo => 'Tap to change video (demo)';

  @override
  String get upvote => 'Upvote';

  @override
  String get howToDoThis => 'How to';

  @override
  String get formTipsTitle => 'Form tips';

  @override
  String get progressDetailTitle => 'Progress';

  @override
  String get progressNotFound => 'This progress post isn\'t available';

  @override
  String get friendProfile => 'Profile';

  @override
  String get friendTabProgress => 'Progress';

  @override
  String get friendTabWorkouts => 'Workouts';

  @override
  String get friendProgress => 'Progress';

  @override
  String get friendExercises => 'Exercises';

  @override
  String get friendWorkoutTimeline => 'Workout timeline';

  @override
  String get friendWorkoutSection => 'Workout';

  @override
  String get friendStatPosts => 'Posts';

  @override
  String get friendStatWorkouts => 'Workouts';

  @override
  String get friendStatStreak => 'Streak';

  @override
  String get friendInbox => 'Inbox';

  @override
  String get friendInboxComingSoon => 'Messaging with friends is coming soon';

  @override
  String get friendFollow => 'Follow';

  @override
  String get friendFollowing => 'Following';

  @override
  String get friendMessage => 'Message';

  @override
  String get friendShareProfile => 'Share profile';

  @override
  String get friendCopyLink => 'Copy link';

  @override
  String get friendLinkCopied => 'Link copied';

  @override
  String get friendStatFollowing => 'Following';

  @override
  String get friendStatFollowers => 'Followers';

  @override
  String get friendStatUpvotes => 'Upvotes';

  @override
  String friendWorkoutExercises(int count) {
    return '$count exercises';
  }

  @override
  String friendWorkoutSets(int count) {
    return '$count sets';
  }

  @override
  String friendWorkoutVolume(String kg) {
    return '$kg kg volume';
  }

  @override
  String friendWorkoutVolumeShort(String kg) {
    return '$kg kg';
  }

  @override
  String get seeMore => 'See more';

  @override
  String get saveForLater => 'Save for later';

  @override
  String get savedForLater => 'Saved';

  @override
  String get savedForLaterSnack => 'Workout saved for later';

  @override
  String get removeFromSaved => 'Remove from saved';

  @override
  String get removedFromSavedSnack => 'Removed from saved';

  @override
  String get saveWorkout => 'Save';

  @override
  String get unsaveWorkout => 'Unsave';

  @override
  String get noFriendWorkoutsYet => 'No workouts logged yet';

  @override
  String workoutSetsRepsWeight(int sets, int reps, String weight) {
    return '$sets×$reps @ $weight kg';
  }

  @override
  String get friendNotFound => 'Friend not found';

  @override
  String get noFriendProgressYet => 'No visible progress yet';

  @override
  String get viewLeaderboard => 'View leaderboard';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get youLabel => 'You';

  @override
  String get sectionComingLater => 'Coming later';

  @override
  String get comingLaterHint => 'Trainers, gyms, and events — soon';

  @override
  String get sectionTrain => 'Train';

  @override
  String rankUpSnack(int rank) {
    return 'You\'re #$rank on the board!';
  }

  @override
  String get activityTitle => 'Activity';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String dayStreakShort(int count) {
    return '$count-day streak';
  }

  @override
  String xpProgress(int xp, int xpToNext) {
    return '$xp / $xpToNext XP';
  }

  @override
  String get statWorkouts => 'Workouts';

  @override
  String get statMinutes => 'Minutes';

  @override
  String get statXp => 'XP';

  @override
  String get sectionRecent => 'Recent';

  @override
  String get profileTitle => 'Profile';

  @override
  String profileLevelIntermediate(int level) {
    return 'Level $level · Intermediate';
  }

  @override
  String locationStreakDays(int days) {
    return 'Addis Ababa · $days-day streak';
  }

  @override
  String get goalsTitle => 'Goals';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsOn => 'On';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacySubtitle => 'Manage who sees your progress';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get settingsFreePlan => 'Free plan';

  @override
  String get replayOnboardingDemo => 'Replay onboarding (demo)';

  @override
  String settingsDemoOnly(String title) {
    return '$title is demo-only';
  }

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get cancel => 'Cancel';

  @override
  String get onboardingPlanTrainingTitle => 'Personalized training';

  @override
  String onboardingPlanTrainingBody(String environment) {
    return 'Sessions built for $environment — the right moves for your gear and space.';
  }

  @override
  String get onboardingPlanCommunityTitle => 'Community that keeps you going';

  @override
  String get onboardingPlanCommunityBody =>
      'Follow friends, share progress, and stay accountable with lifters across Addis.';

  @override
  String get onboardingPlanTrainerTitle => 'Online personal trainers';

  @override
  String get onboardingPlanTrainerBody =>
      'Get coached remotely by vetted trainers who match your goals and schedule.';

  @override
  String get onboardingPlanReadyBadge => 'Personalized for you';
}
