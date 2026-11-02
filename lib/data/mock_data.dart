import '../l10n/localized_string.dart';
import '../models/models.dart';
import 'exercise_images.dart';
import 'exercise_repository.dart';
import 'user_preferences.dart';
import 'workout_catalog.dart';

LocalizedString t(String en, String am, String om) =>
    LocalizedString(en: en, am: am, om: om);

abstract final class MockData {
  static const currentUser = 'Miki';
  static const deliveryArea = 'Ayertena';
  static const streakDays = 12;
  static const level = 8;
  static const xp = 1840;
  static const xpToNext = 2000;

  static final friends = [
    FriendStatus(
      name: 'Abel',
      handle: '@abel',
      status: t('Training', 'በስልጠና ላይ', 'Leenjii irratti'),
      isTraining: true,
      streakDays: 14,
      exerciseIds: const ['ex1', 'ex2', 'ex3'],
      followingCount: 186,
      followersCount: 1240,
      likesCount: 8920,
      bio: t(
        'Push Day addict · 14-day streak',
        'የፑሽ ቀን አፍቃሪ · 14-ቀን ተከታታይ',
        'Jaalattaa guyyaa Push · walitti fufiinsa guyyaa 14',
      ),
    ),
    FriendStatus(
      name: 'Hana',
      handle: '@hana',
      status: t('Finished', 'ጨርሷል', 'Xumure'),
      isTraining: false,
      streakDays: 21,
      exerciseIds: const ['ex7', 'ex5', 'ex6'],
      followingCount: 264,
      followersCount: 21800,
      likesCount: 769700,
      bio: t(
        'Strength + form checks · consistency first',
        'ኃይል + የፎርም ቼኮች · ቋሚነት መጀመሪያ',
        'Cimina + check foormii · dhaabbiin dura',
      ),
    ),
    FriendStatus(
      name: 'Dawit',
      handle: '@dawit',
      status: t('Training', 'በስልጠና ላይ', 'Leenjii irratti'),
      isTraining: true,
      streakDays: 9,
      exerciseIds: const ['ex10', 'ex11', 'ex4'],
      followingCount: 92,
      followersCount: 540,
      likesCount: 2100,
      bio: t(
        'Bulk season · local meals',
        'የባልክ ወቅት · የአካባቢ ምግቦች',
        'Yeroo bulk · nyaata naannoo',
      ),
    ),
    FriendStatus(
      name: 'Sara',
      handle: '@sara',
      status: t('Rest day', 'የእረፍት ቀን', 'Guyyaa boqonnaa'),
      isTraining: false,
      streakDays: 5,
      exerciseIds: const ['ex13', 'ex14'],
      followingCount: 310,
      followersCount: 890,
      likesCount: 4500,
      bio: t(
        'Mobility + recovery days matter',
        'ተንቀሳቃሽነት + የማገገሚያ ቀናት አስፈላጊ ናቸው',
        'Guyyaan sochii + deebi\'uu barbaachisaa dha',
      ),
    ),
  ];

  static DateTime _daysAgo(int days) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day).subtract(Duration(days: days));
  }

  static DateTime _hoursAgo(int hours) =>
      DateTime.now().subtract(Duration(hours: hours));

  static final friendWorkouts = [
    FriendWorkoutSession(
      id: 'ws-abel-1',
      friendName: 'Abel',
      date: _daysAgo(0),
      title: t('Push Day', 'የፑሽ ቀን', 'Guyyaa Pushii'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex1', sets: 4, reps: 8, weightKg: 80),
        FriendWorkoutSet(exerciseId: 'ex2', sets: 3, reps: 10, weightKg: 28),
        FriendWorkoutSet(exerciseId: 'ex3', sets: 3, reps: 12, weightKg: 20),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-abel-2',
      friendName: 'Abel',
      date: _daysAgo(3),
      title: t('Pull Day', 'የፑል ቀን', 'Guyyaa Pull'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex7', sets: 4, reps: 8, weightKg: 70),
        FriendWorkoutSet(exerciseId: 'ex5', sets: 3, reps: 12, weightKg: 14),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-abel-3',
      friendName: 'Abel',
      date: _daysAgo(7),
      title: t('Upper Power', 'የላይኛ ኃይል', 'Humna ol'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex1', sets: 5, reps: 5, weightKg: 85),
        FriendWorkoutSet(exerciseId: 'ex2', sets: 3, reps: 8, weightKg: 30),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-hana-1',
      friendName: 'Hana',
      date: _daysAgo(1),
      title: t('Full Body', 'ሙሉ አካል', 'Qaama guutuu'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex7', sets: 3, reps: 10, weightKg: 40),
        FriendWorkoutSet(exerciseId: 'ex5', sets: 3, reps: 12, weightKg: 10),
        FriendWorkoutSet(exerciseId: 'ex6', sets: 2, reps: 15, weightKg: 0),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-hana-2',
      friendName: 'Hana',
      date: _daysAgo(4),
      title: t('Lower Focus', 'የታችኛ ትኩረት', 'Xiyyeeffannoo gadii'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex8', sets: 4, reps: 8, weightKg: 60),
        FriendWorkoutSet(exerciseId: 'ex9', sets: 3, reps: 10, weightKg: 40),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-hana-3',
      friendName: 'Hana',
      date: _daysAgo(14),
      title: t('Push Volume', 'ፑሽ ቮልዩም', 'Volume Push'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex1', sets: 3, reps: 12, weightKg: 45),
        FriendWorkoutSet(exerciseId: 'ex5', sets: 3, reps: 15, weightKg: 8),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-dawit-1',
      friendName: 'Dawit',
      date: _daysAgo(0),
      title: t('Heavy Legs', 'ከባድ እግር', 'Miila ulfaataa'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex10', sets: 4, reps: 6, weightKg: 100),
        FriendWorkoutSet(exerciseId: 'ex11', sets: 3, reps: 8, weightKg: 80),
        FriendWorkoutSet(exerciseId: 'ex4', sets: 3, reps: 12, weightKg: 25),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-dawit-2',
      friendName: 'Dawit',
      date: _daysAgo(7),
      title: t('Upper Bulk', 'ላይኛ ባልክ', 'Bulk ol'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex1', sets: 4, reps: 8, weightKg: 90),
        FriendWorkoutSet(exerciseId: 'ex11', sets: 3, reps: 10, weightKg: 70),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-sara-1',
      friendName: 'Sara',
      date: _daysAgo(2),
      title: t('Shoulders & Arms', 'ትከሻ እና ክንድ', 'Gurruu fi harka'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex13', sets: 4, reps: 8, weightKg: 40),
        FriendWorkoutSet(exerciseId: 'ex14', sets: 3, reps: 12, weightKg: 12),
      ],
    ),
    FriendWorkoutSession(
      id: 'ws-sara-2',
      friendName: 'Sara',
      date: _daysAgo(9),
      title: t('Conditioning', 'ኮንዲሽኒንግ', 'Kondishiningii'),
      sets: const [
        FriendWorkoutSet(exerciseId: 'ex6', sets: 3, reps: 20, weightKg: 0),
        FriendWorkoutSet(exerciseId: 'ex14', sets: 3, reps: 15, weightKg: 10),
      ],
    ),
  ];

  static List<WorkoutPlan> get recommendedWorkouts =>
      WorkoutCatalog.plansFrom(ExerciseRepository.instance.exercises);

  static WorkoutPlan get todaysWorkout {
    final plans = recommendedWorkouts;
    if (plans.isEmpty) {
      return WorkoutPlan(
        id: 'w1',
        title: t('Chest + Triceps', 'ደረት + ትራይሴፕስ', 'Qoma + Tiraayseepsii'),
        durationMinutes: 45,
        level: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
        muscles: [
          t('Chest', 'ደረት', 'Qoma'),
          t('Shoulders', 'ትከሻዎች', 'Gurruu'),
          t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
        ],
        owner: currentUser,
        tag: t('Today', 'ዛሬ', 'Har\'a'),
        exercises: const [],
      );
    }
    for (final plan in plans) {
      if (plan.id == 'w1') return plan;
    }
    return plans.first;
  }

  static final muscleFilters = [
    t('Full body', 'ሙሉ አካል', 'Qaama guutuu'),
    t('Chest', 'ደረት', 'Qoma'),
    t('Back', 'ጀርባ', 'Dugda'),
    t('Legs', 'እግሮች', 'Miila'),
    t('Shoulders', 'ትከሻዎች', 'Gurruu'),
    t('Arms', 'እጆች', 'Harka'),
    t('Core', 'ኮር', 'Kooree'),
  ];

  static String? muscleImageAsset(String muscleEn) {
    return switch (muscleEn) {
      'Chest' => 'assets/images/target-muscles/chest.png',
      'Back' => 'assets/images/target-muscles/back.png',
      'Legs' => 'assets/images/target-muscles/leg.png',
      'Shoulders' => 'assets/images/target-muscles/shoulder.png',
      'Arms' => 'assets/images/target-muscles/arm.png',
      'Core' => 'assets/images/target-muscles/abs.png',
      'Full body' => 'assets/images/target-muscles/fullbody.png',
      _ => null,
    };
  }

  static final equipmentFilters = [
    t('Bodyweight', 'የሰውነት ክብደት', 'Ulfaatina qaamaa'),
    t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
    t('Barbell', 'ባርቤል', 'Baarbeelii'),
    t('Cable', 'ኬብል', 'Keebilii'),
  ];

  static List<WorkoutPlan> workoutsForMuscles(
    Set<String> muscleEn, {
    Set<TrainingEnvironment>? environments,
  }) {
    Iterable<WorkoutPlan> list = recommendedWorkouts;
    if (environments != null && environments.isNotEmpty) {
      list = list.where((w) => workoutMatchesEnvironments(w, environments));
    }
    if (muscleEn.isEmpty) return list.toList();
    return list.where((w) {
      return muscleEn.any((muscle) {
        return w.muscles.any(
          (m) =>
              m.en.toLowerCase().contains(muscle.toLowerCase()) ||
              (muscle == 'Full body' && m.en.toLowerCase().contains('full')),
        );
      });
    }).toList();
  }

  static List<WorkoutPlan> workoutsForMuscle(
    String? muscleEn, {
    Set<TrainingEnvironment>? environments,
  }) {
    if (muscleEn == null || muscleEn == 'All') {
      return workoutsForMuscles({}, environments: environments);
    }
    return workoutsForMuscles({muscleEn}, environments: environments);
  }

  static List<WorkoutPlan> workoutsForFilters({
    Set<String> muscleEn = const {},
    Set<String> equipmentEn = const {},
  }) {
    var list = workoutsForMuscles(muscleEn);
    if (equipmentEn.isEmpty) return list;
    return list.where((w) {
      if (w.exercises.isEmpty) return false;
      return w.exercises.every(
        (we) => equipmentEn.contains(we.exercise.equipment.en),
      );
    }).toList();
  }

  static List<WorkoutPlan> workoutsForEnvironments(
    Set<TrainingEnvironment> environments,
  ) {
    return recommendedWorkouts
        .where((w) => workoutMatchesEnvironments(w, environments))
        .toList();
  }

  static WorkoutPlan todaysWorkoutFor(Set<TrainingEnvironment> environments) {
    final preferredId = () {
      if (environments.contains(TrainingEnvironment.gym)) return 'w1';
      if (environments.contains(TrainingEnvironment.home)) return 'w3';
      if (environments.contains(TrainingEnvironment.noEquipment)) return 'w4';
      return 'w1';
    }();
    final matched = workoutsForEnvironments(environments);
    for (final w in matched) {
      if (w.id == preferredId) return w;
    }
    if (matched.isNotEmpty) return matched.first;
    return todaysWorkout;
  }

  static final products = <ShopProduct>[
    ShopProduct(
      id: 'p1',
      title: t('Whey Protein Isolate', 'ዌይ ፕሮቲን አይሶሌት', 'Whey Protein Isolate'),
      blurb: t(
        '30g protein per scoop · chocolate',
        'በአንድ ስኩፕ 30ግ ፕሮቲን · ቸኮሌት',
        'Pirootiinii 30g scooplatti · shookoleetii',
      ),
      priceEtb: 1890,
      compareAtPriceEtb: 2490,
      discountPercent: 24,
      kind: ShopProductKind.protein,
      imageAsset: ExerciseImages.forId('ex5'),
    ),
    ShopProduct(
      id: 'p2',
      title: t(
        'All-in-One Home Kit',
        'ሁሉን-በአንድ የቤት ኪት',
        'Meeshaa Manaa Hunda-Tokko',
      ),
      blurb: t(
        'Bands, door anchor, and handles — no gym needed',
        'ባንዶች፣ የበር ማያያዣ እና እጀታዎች — ጂም አያስፈልግም',
        'Baandii, futikaan balbalaa, fi qabduu — jiimi hin barbaachisu',
      ),
      priceEtb: 2490,
      compareAtPriceEtb: 3490,
      discountPercent: 29,
      kind: ShopProductKind.homeKit,
      imageAsset: 'assets/images/onbaording/online-trainer.png',
    ),
    ShopProduct(
      id: 'p3',
      title: t('Resistance Bands Set', 'የመቋቋም ባንድ ስብስብ', 'Baandii Dhiibbaa'),
      blurb: t(
        '5 levels · travel pouch included',
        '5 ደረጃዎች · የጉዞ ቦርሳ ይጨምራል',
        'Sadarkaa 5 · korojoo imalaa wajjin',
      ),
      priceEtb: 650,
      compareAtPriceEtb: 890,
      discountPercent: 27,
      kind: ShopProductKind.accessory,
      imageAsset: ExerciseImages.forId('ex12'),
    ),
  ];

  static ShopProduct? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  /// Ordered offers for the user's training setup.
  static List<ShopProduct> personalizedProducts(
    Set<TrainingEnvironment> environments,
  ) {
    ShopProduct byKind(ShopProductKind kind) =>
        products.firstWhere((p) => p.kind == kind);

    final protein = byKind(ShopProductKind.protein);
    final homeKit = byKind(ShopProductKind.homeKit);
    final accessory = byKind(ShopProductKind.accessory);

    if (environments.contains(TrainingEnvironment.noEquipment)) {
      return [homeKit, protein, accessory];
    }
    if (environments.contains(TrainingEnvironment.home)) {
      return [homeKit, protein, accessory];
    }
    return [protein, accessory, homeKit];
  }

  static final gyms = [
    GymPlace(
      id: 'g1',
      name: 'Power Fitness',
      distanceKm: 1.2,
      rating: 4.6,
      openUntil: t('10 PM', 'ማታ 10:00', 'Sa\'aatii 10 galgala'),
      checkedInToday: 24,
      members: 327,
      activeThisWeek: 34,
      priceLabel: t('2,500 ETB / mo', '2,500 ብር / ወር', 'ETB 2,500 / ji\'a'),
      amenities: [
        t('Free weights', 'ነፃ ክብደቶች', 'Ulfaatina bilisaa'),
        t('Machines', 'ማሽኖች', 'Maashinoota'),
        t('Showers', 'ሻወሮች', 'Showaroota'),
        t('Classes', 'ክፍሎች', 'Daree'),
      ],
      address: t('Bole, Addis Ababa', 'ቦሌ፣ አዲስ አበባ', 'Boolee, Finfinnee'),
    ),
    GymPlace(
      id: 'g2',
      name: 'Prime Strength Lab',
      distanceKm: 2.4,
      rating: 4.8,
      openUntil: t('11 PM', 'ማታ 11:00', 'Sa\'aatii 11 galgala'),
      checkedInToday: 18,
      members: 210,
      activeThisWeek: 41,
      priceLabel: t('3,200 ETB / mo', '3,200 ብር / ወር', 'ETB 3,200 / ji\'a'),
      amenities: [
        t('Power racks', 'ፓወር ራኮች', 'Paawar raakii'),
        t('Olympic platform', 'ኦሎምፒክ መድረክ', 'Pilaatformii Olimpikii'),
        t('Sauna', 'ሳውና', 'Saawunaa'),
      ],
      address: t(
        'Kazanchis, Addis Ababa',
        'ካዛንቺስ፣ አዲስ አበባ',
        'Kaazaanchis, Finfinnee',
      ),
    ),
    GymPlace(
      id: 'g3',
      name: 'FitZone CMC',
      distanceKm: 3.1,
      rating: 4.3,
      openUntil: t('9 PM', 'ማታ 9:00', 'Sa\'aatii 9 galgala'),
      checkedInToday: 12,
      members: 480,
      activeThisWeek: 52,
      priceLabel: t('1,800 ETB / mo', '1,800 ብር / ወር', 'ETB 1,800 / ji\'a'),
      amenities: [
        t('Cardio', 'ካርዲዮ', 'Kaardiyoo'),
        t('Group classes', 'የቡድን ክፍሎች', 'Daree garee'),
        t('Parking', 'መኪና ማቆሚያ', 'Iddoo konkolaataa'),
      ],
      address: t('CMC, Addis Ababa', 'ሲኤምሲ፣ አዲስ አበባ', 'CMC, Finfinnee'),
    ),
  ];

  static final feed = [
    FeedPost(
      id: 'f0',
      author: 'Hana',
      type: t('Progress', 'ሂደት', 'Adeemsa'),
      body: t(
        'Week 6 check-in. Feeling stronger in the mirror.',
        'የ6ኛ ሳምንት ቼክ-ኢን። በመስተዋቱ ጠንካራ እየተሰማኝ ነው።',
        'Check-in torbee 6. Meeshaa keessatti cimaa natti dhaga\'ama.',
      ),
      timeAgo: t('8m', '8ደ', '8d'),
      reactions: 41,
      media: [
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: t('Front', 'ፊት', 'Fuuldura'),
        ),
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: t('Side', 'ጎን', 'Cinaacha'),
        ),
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: t('Back', 'ጀርባ', 'Dugda'),
        ),
      ],
      weightKg: 62.5,
      emotionEmoji: '🤩',
      meta: t('Proud', 'ኩራተኛ', 'Ofitti jajjabaa'),
      visibility: ProgressVisibility.publicFeed,
      exerciseIds: const ['ex7', 'ex5'],
      workoutSessionId: 'ws-hana-1',
      postedAt: _daysAgo(1),
    ),
    FeedPost(
      id: 'f1',
      author: 'Abel',
      type: t('Workout', 'የአካል ብቃት', 'Shaakala'),
      body: t(
        'Just crushed Push Day at Power Fitness. Bench felt strong today.',
        'በPower Fitness የፑሽ ቀን በደንብ ጨረስኩ። ቤንቹ ዛሬ ጠንካራ ነበር።',
        'Guyyaa Pushii Power Fitness irratti cimseen xumure. Beenchii har\'a cimaa ture.',
      ),
      timeAgo: t('12m', '12ደ', '12d'),
      reactions: 18,
      meta: t('45 min · 7 exercises', '45 ደቂቃ · 7 ልምምዶች', 'Daqiiqaa 45 · shaakala 7'),
      media: [
        ProgressMediaItem(
          kind: ProgressMediaKind.video,
          label: t('Form check clip', 'የፎርም ቪዲዮ', 'Viidiyoo foormii'),
        ),
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: t('Bench setup', 'የቤንች አቀማመጥ', 'Qopheessuu beenchii'),
        ),
        ProgressMediaItem(
          kind: ProgressMediaKind.photo,
          label: t('Lockout PR', 'የሎክአውት PR', 'PR Lockout'),
        ),
      ],
      visibility: ProgressVisibility.friendsOnly,
      exerciseIds: const ['ex1', 'ex2', 'ex3'],
      workoutSessionId: 'ws-abel-1',
      postedAt: _daysAgo(0),
    ),
    FeedPost(
      id: 'f2',
      author: 'Hana',
      type: t('Achievement', 'ስኬት', 'Milkaa\'ina'),
      body: t(
        'Hit a 14-day streak! Small wins stack up.',
        'የ14 ቀን ተከታታይነት መታኝ! ትናንሽ ድሎች ይከማቻሉ።',
        'Walitti fufiinsa guyyaa 14! Injifannoon xixiqqoon walitti qabama.',
      ),
      timeAgo: t('1h', '1ሰ', '1s'),
      reactions: 32,
      meta: t('🔥 Streak badge', '🔥 የተከታታይነት ባጅ', '🔥 Badgee walitti fufiinsa'),
      visibility: ProgressVisibility.publicFeed,
      postedAt: _daysAgo(4),
    ),
    FeedPost(
      id: 'f6',
      author: 'Dawit',
      type: t('Progress', 'ሂደት', 'Adeemsa'),
      body: t(
        'Bulk update — leaning into local meals this month.',
        'የባልክ ዝመና — በዚህ ወር የአካባቢ ምግቦች ላይ አተኩራለሁ።',
        'Haaromsa bulk — ji\'a kana nyaata naannoo irratti xiyyeeffadha.',
      ),
      timeAgo: t('90m', '90ደ', '90d'),
      reactions: 15,
      photoLabel: t('Side', 'ጎን', 'Cinaacha'),
      weightKg: 78.5,
      emotionEmoji: '💪',
      meta: t('Strong', 'ጠንካራ', 'Cimaa'),
      visibility: ProgressVisibility.friendsOnly,
      exerciseIds: const ['ex10', 'ex11'],
      workoutSessionId: 'ws-dawit-1',
      postedAt: _daysAgo(0),
    ),
    FeedPost(
      id: 'f7',
      author: currentUser,
      type: t('Progress', 'ሂደት', 'Adeemsa'),
      body: t(
        'Private journal — noting energy after heavy legs.',
        'የግል ማስታወሻ — ከከባድ እግር በኋላ ኢነርጂ።',
        'Sinkuu dhuunfaa — anniisaa erga miila ulfaataa booda.',
      ),
      timeAgo: t('3h', '3ሰ', '3s'),
      reactions: 0,
      photoLabel: t('Gym mirror', 'የጂም መስተዋት', 'Meeshaa jiimii'),
      emotionEmoji: '😌',
      meta: t('Calm', 'የረጋ', 'Tasgabbaa\'aa'),
      visibility: ProgressVisibility.privateOnly,
      exerciseIds: const ['ex8', 'ex9'],
      postedAt: _hoursAgo(3),
    ),
    FeedPost(
      id: 'f3',
      author: 'Dawit',
      type: t('Check-in', 'ቼክ-ኢን', 'Check-in'),
      body: t(
        'Checked in at Prime Strength Lab. Who is training tonight?',
        'በPrime Strength Lab ቼክ-ኢን አደረግሁ። ዛሬ ማታ ማን ይሰለጥናል?',
        'Prime Strength Lab irratti check-in godhe. Eenyutu galgala kana leenjii godha?',
      ),
      timeAgo: t('2h', '2ሰ', '2s'),
      reactions: 9,
      meta: t('Prime Strength Lab', 'ፕራይም ስትረንግዝ ላብ', 'Prime Strength Lab'),
      visibility: ProgressVisibility.publicFeed,
      postedAt: _daysAgo(2),
    ),
    FeedPost(
      id: 'f4',
      author: 'Sara',
      type: t('Challenge', 'ፈተና', 'Qormaata'),
      body: t(
        'September Consistency Challenge — day 18/30. Still in.',
        'የመስከረም ተከታታይነት ፈተና — ቀን 18/30። አሁንም ውስጥ ነኝ።',
        'Qormaata Walitti Fufiinsa Fulbaanaa — guyyaa 18/30. Ammaa keessa jira.',
      ),
      timeAgo: t('4h', '4ሰ', '4s'),
      reactions: 24,
      meta: t('City challenge', 'የከተማ ፈተና', 'Qormaata magaalataa'),
      visibility: ProgressVisibility.publicFeed,
      postedAt: _daysAgo(1),
    ),
    FeedPost(
      id: 'f5',
      author: 'Yonas',
      type: t('Question', 'ጥያቄ', 'Gaaffii'),
      body: t(
        'Best high-protein lunch spots near Bole for muscle gain?',
        'ለጡንቻ ማሳደግ በቦሌ አቅራቢያ ምርጥ ከፍተኛ ፕሮቲን ምሳ ቦታዎች?',
        'Bakkeewwan nyaataa pirootiinii olaanaa Boolee dhihoo guddina maashaaf?',
      ),
      timeAgo: t('5h', '5ሰ', '5s'),
      reactions: 11,
      visibility: ProgressVisibility.publicFeed,
      postedAt: _hoursAgo(5),
    ),
  ];

  static final progressPhotoOptions = [
    t('Front', 'ፊት', 'Fuuldura'),
    t('Side', 'ጎን', 'Cinaacha'),
    t('Gym mirror', 'የጂም መስተዋት', 'Meeshaa jiimii'),
  ];

  static final progressVideoOptions = [
    t('Form check clip', 'የፎርም ቪዲዮ', 'Viidiyoo foormii'),
    t('PR attempt', 'የፒአር ሙከራ', 'Yaaliin PR'),
    t('Gym vibe reel', 'የጂም ሪል', 'Riilii jiimii'),
  ];

  static final challenges = [
    ChallengeInfo(
      id: 'c1',
      title: t(
        'September Consistency',
        'የመስከረም ተከታታይነት',
        'Walitti Fufiinsa Fulbaanaa',
      ),
      subtitle: t(
        'Train 20 days this month',
        'በዚህ ወር 20 ቀን ስልጠን',
        'Ji\'a kana guyyaa 20 leenjii godhi',
      ),
      progress: 12,
      goal: 20,
      daysLeft: 8,
      participants: 184,
      type: 'City',
      typeLabel: t('City', 'ከተማ', 'Magaalaa'),
    ),
    ChallengeInfo(
      id: 'c2',
      title: t(
        'Power Fitness September',
        'ፓወር ፊትነስ መስከረም',
        'Power Fitness Fulbaana',
      ),
      subtitle: t(
        'Gym community challenge',
        'የጂም ማህበረሰብ ፈተና',
        'Qormaata hawaasa jiimii',
      ),
      progress: 8,
      goal: 12,
      daysLeft: 10,
      participants: 64,
      type: 'Gym',
      typeLabel: t('Gym', 'ጂም', 'Jiimii'),
    ),
    ChallengeInfo(
      id: 'c3',
      title: t('The Boys 💪', 'ወንዶቹ 💪', 'Dhiironni 💪'),
      subtitle: t(
        'Accountability group — 4 workouts / week',
        'የተጠያቂነት ቡድን — በሳምንት 4 የአካል ብቃት',
        'Garee itti gaafatamummaa — shaakala 4 / torbee',
      ),
      progress: 3,
      goal: 4,
      daysLeft: 2,
      participants: 5,
      type: 'Friends',
      typeLabel: t('Friends', 'ጓደኞች', 'Hiriyoota'),
    ),
    ChallengeInfo(
      id: 'c4',
      title: t(
        '30-Day Workout Streak',
        'የ30 ቀን የአካል ብቃት ተከታታይነት',
        'Walitti Fufiinsa Shaakalaa Guyyaa 30',
      ),
      subtitle: t(
        'Personal challenge — show up daily',
        'የግል ፈተና — በየቀኑ ተገኝ',
        'Qormaata dhuunfaa — guyyaa guyyaa dhufi',
      ),
      progress: 12,
      goal: 30,
      daysLeft: 18,
      participants: 1,
      type: 'Personal',
      typeLabel: t('Personal', 'ግላዊ', 'Dhuunfaa'),
    ),
    ChallengeInfo(
      id: 'c5',
      title: t(
        '1000 Workouts Addis',
        '1000 የአካል ብቃት አዲስ',
        'Shaakala 1000 Finfinnee',
      ),
      subtitle: t(
        'Community milestone challenge',
        'የማህበረሰብ ምዕራፍ ፈተና',
        'Qormaata milkaa\'ina hawaasaa',
      ),
      progress: 640,
      goal: 1000,
      daysLeft: 21,
      participants: 412,
      type: 'Community',
      typeLabel: t('Community', 'ማህበረሰብ', 'Hawaasa'),
    ),
  ];

  static final challengeFilters = [
    t('All', 'ሁሉም', 'Hunda'),
    t('Personal', 'ግላዊ', 'Dhuunfaa'),
    t('Friends', 'ጓደኞች', 'Hiriyoota'),
    t('Gym', 'ጂም', 'Jiimii'),
    t('City', 'ከተማ', 'Magaalaa'),
    t('Community', 'ማህበረሰብ', 'Hawaasa'),
  ];

  static List<ChallengeInfo> challengesForType(String? typeEn) {
    if (typeEn == null || typeEn == 'All') return challenges;
    return challenges.where((c) => c.type == typeEn).toList();
  }

  static final trainers = [
    TrainerProfile(
      id: 't1',
      name: 'Liya Bekele',
      specialization: t(
        'Strength & Hypertrophy',
        'ጥንካሬ እና ሃይፐርትሮፊ',
        'Cimina & Haaypartoofii',
      ),
      yearsExperience: 6,
      gym: 'Power Fitness',
      rating: 4.9,
      pricePerSessionEtb: 800,
      availability: t(
        'Mon–Fri · mornings',
        'ሰኞ–አርብ · ጠዋት',
        'Wiixata–Jimaata · ganama',
      ),
      bio: t(
        'Helps lifters in Addis build muscle with progressive programs and form-first coaching.',
        'በአዲስ አበባ አንሻላዎችን በሂደታዊ ፕሮግራሞች እና በቅርጽ ቀዳሚ አሰልጣኝነት ጡንቻ እንዲገነቡ ትረዳለች።',
        'Kaastota Finfinnee progiraamii adeemsaa fi leenjii foormii duraan maashaa akka ijaaran gargaarti.',
      ),
      location: t('Bole, Addis Ababa', 'ቦሌ፣ አዲስ አበባ', 'Boolee, Finfinnee'),
      offersInPerson: true,
      offersOnline: false,
      programs: [
        t(
          '12-Week Muscle Builder',
          'የ12 ሳምንት ጡንቻ ገንቢ',
          'Ijaarsa Maashaa Torbee 12',
        ),
        t(
          'Beginner Gym Confidence',
          'የጀማሪ ጂም በራስ መተማመን',
          'Ofitti Amana Jiimii Jalqabaa',
        ),
        t(
          'Form Fix Sessions',
          'የቅርጽ ማስተካከያ ክፍለ ጊዜዎች',
          'Seshinoota Foormii Sirreessuu',
        ),
      ],
      certifications: const [
        TrainerCertification(
          name: 'NASM Certified Personal Trainer',
          issuer: 'NASM',
          year: 2019,
        ),
        TrainerCertification(
          name: 'NSCA Certified Strength & Conditioning Specialist',
          issuer: 'NSCA',
          year: 2021,
        ),
        TrainerCertification(
          name: 'CPR/AED',
          issuer: 'Red Cross',
          year: 2024,
        ),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Meron K.',
          rating: 5.0,
          text: t(
            'Liya rebuilt my squat form in three sessions — I added 20 kg in two months.',
            'ሊያ በሶስት ክፍለ ጊዜዎች የስኳት ቅርጼን አስተካከለች — በሁለት ወር 20 ኪግ ጨመርኩ።',
            'Liyaan foormii iskuwatii koo sesshinii sadii keessatti sirreessite — ji\'a lama keessatti kg 20 dabalee.',
          ),
        ),
        TrainerTestimonial(
          author: 'Robel D.',
          rating: 4.5,
          text: t(
            'Structured programs, honest feedback, and she actually answers messages between sessions.',
            'ዝግጁ ፕሮግራሞች፣ ታማኝ ግብረመልስ፣ እና በክፍለ ጊዜዎች መካከል መልእክቶችን ትመልሳለች።',
            'Sagantaawwan qindaa\'an, deebii dhugaa, fi sesshinii gidduutti ergaalees deebisti.',
          ),
        ),
      ],
    ),
    TrainerProfile(
      id: 't2',
      name: 'Yonatan Hailu',
      specialization: t(
        'Fat Loss & Conditioning',
        'ስብ ማጣት እና ኮንዲሽኒንግ',
        'Hir\'ina Dhangala\'aa & Kondishiningii',
      ),
      yearsExperience: 4,
      gym: 'FitZone CMC',
      rating: 4.7,
      pricePerSessionEtb: 650,
      availability: t(
        'Evenings · weekends',
        'ማታ · የሳምንት መጨረሻ',
        'Galgala · dhuma torbee',
      ),
      bio: t(
        'High-energy conditioning coach focused on sustainable fat loss and local meal habits.',
        'በዘላቂ የስብ ማጣት እና የአካባቢ የምግብ ልማዶች ላይ ያተኮረ ከፍተኛ ኢነርጂ ኮንዲሽኒንግ አሰልጣኝ።',
        'Koachii kondishiningii anniisaa olaanaa hir\'ina dhangala\'aa itti fufiinsaa fi amala nyaata naannoo irratti xiyyeeffate.',
      ),
      location: t('CMC, Addis Ababa', 'ሲኤምሲ፣ አዲስ አበባ', 'CMC, Finfinnee'),
      offersInPerson: true,
      offersOnline: true,
      programs: [
        t(
          '8-Week Fat Loss Sprint',
          'የ8 ሳምንት የስብ ማጣት ስፕሪንት',
          'Ispiriintii Hir\'ina Dhangala\'aa Torbee 8',
        ),
        t('HIIT Conditioner', 'HIIT ኮንዲሽነር', 'Kondishinarrii HIIT'),
        t(
          'Accountability Check-ins',
          'የተጠያቂነት ቼክ-ኢኖች',
          'Check-in Itti Gaafatamummaa',
        ),
      ],
      certifications: const [
        TrainerCertification(
          name: 'ACE Personal Trainer',
          issuer: 'ACE',
          year: 2021,
        ),
        TrainerCertification(
          name: 'Precision Nutrition Level 1',
          issuer: 'Precision Nutrition',
          year: 2022,
        ),
        TrainerCertification(name: 'CPR/AED', issuer: 'Red Cross', year: 2023),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Tigist A.',
          rating: 5.0,
          text: t(
            'Lost 8 kg in the 8-week sprint without giving up injera — his meal tweaks are realistic.',
            'በ8 ሳምንቱ ስፕሪንት እንጀራ ሳልተው 8 ኪግ አጣሁ — የምግብ ማስተካከያዎቹ እውነተኛ ናቸው።',
            'Ispiriintii torban 8 keessatti kg 8 hir\'isee, buddeena dhiisuun malee — jijjiiramni nyaataa isaa dhugaafataa dha.',
          ),
        ),
        TrainerTestimonial(
          author: 'Samuel G.',
          rating: 4.5,
          text: t(
            'HIIT sessions are tough but fun; he keeps you accountable every week.',
            'የHIIT ክፍለ ጊዜዎች ከባድ ግን አስደሳች ናቸው፤ ሳምንት ሳምንት ተጠያቂ ያደርግዎታል።',
            'Sesshinootni HIIT cimaa garuu gammachuu qabu; torban hunda itti gaafatama si taasisa.',
          ),
        ),
      ],
    ),
    TrainerProfile(
      id: 't3',
      name: 'Sara Mengistu',
      specialization: t(
        'Mobility & Rehab-friendly',
        'ተንቀሳቃሽነት እና ለሪሃብ ተስማሚ',
        'Sochii & Rihaab-mijataa',
      ),
      yearsExperience: 8,
      gym: 'Prime Strength Lab',
      rating: 4.8,
      pricePerSessionEtb: 900,
      availability: t(
        'Tue–Sat · afternoons',
        'ማክሰኞ–ቅዳሜ · ከሰዓት በኋላ',
        'Kibxata–Sanbata · waaree booda',
      ),
      bio: t(
        'Mobility-first training for desk workers and returning athletes around Bole.',
        'በቦሌ አካባቢ ለቢሮ ሰራተኞች እና ለተመለሱ አትሌቶች ተንቀሳቃሽነት ቀዳሚ ስልጠና።',
        'Leenjii sochii duraa hojjettoota deeskii fi atileetota deebi\'an Boolee naannoo.',
      ),
      location: t(
        'Kazanchis, Addis Ababa',
        'ካዛንቺስ፣ አዲስ አበባ',
        'Kaazaanchis, Finfinnee',
      ),
      offersInPerson: true,
      offersOnline: true,
      programs: [
        t('Desk Athlete Reset', 'የቢሮ አትሌት ዳግም ማስጀመር', 'Resetii Atileetii Deeskii'),
        t(
          'Joint-Friendly Strength',
          'ለመገጣጠሚያ ተስማሚ ጥንካሬ',
          'Cimina Mijataa Gidduu',
        ),
        t('Posture & Core', 'አቋም እና ኮር', 'Haala Qaamaa & Kooree'),
      ],
      certifications: const [
        TrainerCertification(
          name: 'FRC Mobility Specialist',
          issuer: 'Functional Range Conditioning',
          year: 2020,
        ),
        TrainerCertification(
          name: 'NASM Corrective Exercise Specialist',
          issuer: 'NASM',
          year: 2021,
        ),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Betelhem W.',
          rating: 5.0,
          text: t(
            'My lower-back pain is gone after six weeks of her mobility plan.',
            'በስድስት ሳምንት የተንቀሳቃሽነት እቅዷ የደረባ ህመም ነጠቀኝ።',
            'Dhukkubni dugda kooa gadii pilaanii sochii ishee torban jaa\'aa booda dhaane.',
          ),
        ),
        TrainerTestimonial(
          author: 'Kebede T.',
          rating: 4.5,
          text: t(
            'Great for desk workers — my shoulders finally move freely again.',
            'ለቢሮ ሰራተኞች በጣም ጥሩ — ትከሻዬ በመጨረሻ ነፃነት እንደገና እንቀሳቀሳል።',
            'Hojjettoota deeskii baay\'ee gaarii — gat\'oo koo dhumarratti bilisaan socho\'e.',
          ),
        ),
      ],
    ),
    TrainerProfile(
      id: 't4',
      name: 'Abel Tadesse',
      specialization: t('Olympic Lifting', 'ኦሎምፒክ ማንሳት', 'Kaasuu Olimpikii'),
      yearsExperience: 5,
      gym: 'Prime Strength Lab',
      rating: 4.6,
      pricePerSessionEtb: 950,
      availability: t(
        'Mon / Wed / Fri · evenings',
        'ሰኞ / ረቡዕ / አርብ · ማታ',
        'Wiixata / Roobii / Jimaata · galgala',
      ),
      bio: t(
        'Technique-focused Olympic lifting coach for intermediate athletes.',
        'ለመካከለኛ አትሌቶች በቴክኒክ ላይ ያተኮረ የኦሎምፒክ ማንሳት አሰልጣኝ።',
        'Koachii kaasuu olimpikii teekinikii irratti xiyyeeffate atileetota giddugaleessaaf.',
      ),
      location: t(
        'Kazanchis, Addis Ababa',
        'ካዛንቺስ፣ አዲስ አበባ',
        'Kaazaanchis, Finfinnee',
      ),
      offersInPerson: true,
      offersOnline: false,
      programs: [
        t('Snatch Foundations', 'የስናች መሠረቶች', 'Bu\'uura Snaachii'),
        t('Clean & Jerk Cycle', 'ክሊን እና ጀርክ ዑደት', 'Saaykilii Kiliin & Jerk'),
        t('Competition Prep', 'የውድድር ዝግጅት', 'Qophii Dorgommii'),
      ],
      certifications: const [
        TrainerCertification(
          name: 'Eleiko Weightlifting Coach Level 2',
          issuer: 'Eleiko',
          year: 2021,
        ),
        TrainerCertification(name: 'CPR/AED', issuer: 'Red Cross', year: 2023),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Nahom S.',
          rating: 5.0,
          text: t(
            'His cue-based coaching finally fixed my snatch turnover.',
            'በምልክት ላይ የተመሠረተ አሰልጣኝነቱ የስናች ተርንኦቨሬን በመጨረሻ አስተካከለ።',
            'Koachingni isaa mallattoo irratti hundaa\'e turnover snaachii koo dhumarratti sirreesse.',
          ),
        ),
        TrainerTestimonial(
          author: 'Eden M.',
          rating: 4.5,
          text: t(
            'Strict but patient — competition prep felt organized from day one.',
            'ጥብቅ ግን ትዕግሥት ያለው — የውድድር ዝግጅት ከቀን አንድ ጀምሮ የተዋቀረ ነበር።',
            'Cimaa garuu obsa qabu — qophiin dorgommii guyyaa tokkoo kaasee qindaa\'ee ture.',
          ),
        ),
      ],
    ),
    TrainerProfile(
      id: 't5',
      name: 'Hanna Girma',
      specialization: t(
        'Online Coaching',
        'የመስመር ላይ አሰልጣኝነት',
        'Koachii onlaayinii',
      ),
      yearsExperience: 3,
      gym: 'Remote',
      rating: 4.5,
      pricePerSessionEtb: 400,
      availability: t('Flexible', 'ተለዋዋጭ', 'Mijataa'),
      bio: t(
        'Remote programming with weekly video check-ins so you can train from anywhere.',
        'ከማንኛውም ቦታ እንድትልማመዱ የሚያስችል ሳምንታዊ የቪዲዮ ቼክ-ኢኖች ያሉት የርቀት ፕሮግራም።',
        'Progiraamii fageenya check-in viidiyoo torban hundaatiin bakka kamu irraa akka leenjitan.',
      ),
      location: t('Online', 'መስመር ላይ', 'Onlaayinii'),
      offersInPerson: false,
      offersOnline: true,
      programs: [
        t(
          'Remote Strength Plan',
          'የርቀት ጥንካሬ እቅድ',
          'Pilaanii Ciminaa Fageenya',
        ),
        t(
          'Weekly Video Check-ins',
          'ሳምንታዊ የቪዲዮ ቼክ-ኢኖች',
          'Check-in Viidiyoo Torbanii',
        ),
      ],
      certifications: const [
        TrainerCertification(
          name: 'NASM Certified Personal Trainer',
          issuer: 'NASM',
          year: 2022,
        ),
        TrainerCertification(
          name: 'Precision Nutrition Level 1',
          issuer: 'Precision Nutrition',
          year: 2023,
        ),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Bontu S.',
          rating: 5.0,
          text: t(
            'Weekly video check-ins keep me consistent even while traveling.',
            'ሳምንታዊ የቪዲዮ ቼክ-ኢኖች እንኳን በጉዞ ላይ ሳለሁ ቀጣይ እንድሆን ያደረጉኛል።',
            'Check-in viidiyoo torbanii imala irrattillee itti fufiinsa naaf kenne.',
          ),
        ),
        TrainerTestimonial(
          author: 'Abdi F.',
          rating: 4.5,
          text: t(
            'Programming is clear and she adjusts quickly when my schedule changes.',
            'ፕሮግራሟ ግልጽ ነው እና መርሃ ግብሬ ሲለወጥ በፍጥነት ታስተካክላለች።',
            'Sagantaan ishee ifa dha, yeroon koo yeroo jijjiiramu ariitidhaan sirreessiti.',
          ),
        ),
      ],
    ),
    TrainerProfile(
      id: 't6',
      name: 'Dawit Alemu',
      specialization: t(
        'Beginner & Weight Loss',
        'ጀማሪ እና ክብደት መቀነስ',
        'Jalqabaa & Hir\'ina Ulfaatinaa',
      ),
      yearsExperience: 7,
      gym: 'Adama Fitness Club',
      rating: 4.4,
      pricePerSessionEtb: 500,
      availability: t(
        'Mon–Sat · afternoons',
        'ሰኞ–ቅዳሜ · ከሰዓት በኋላ',
        'Wiixata–Sanbata · waaree booda',
      ),
      bio: t(
        'Patient coach in Adama helping beginners build habits and lose weight safely.',
        'በአዳማ ጀማሪዎች ልማድ እንዲገነቡ እና ክብደት በደህና እንዲቀንሱ የሚረዳ ትዕግሥት ያለው አሰልጣኝ።',
        'Koachii obsa qabu Adaamaa jalqabtoota amala ijaaruu fi ulfaatina salphaatti hir\'isuuf gargaaru.',
      ),
      location: t('Adama', 'አዳማ', 'Adaamaa'),
      offersInPerson: true,
      offersOnline: false,
      programs: [
        t(
          'Beginner Foundations',
          'የጀማሪ መሠረቶች',
          'Bu\'uurawwan Jalqabaa',
        ),
        t(
          '12-Week Weight Loss',
          'የ12 ሳምንት ክብደት መቀነስ',
          'Hir\'ina Ulfaatinaa Torbee 12',
        ),
      ],
      certifications: const [
        TrainerCertification(
          name: 'ISSA Certified Fitness Trainer',
          issuer: 'ISSA',
          year: 2017,
        ),
        TrainerCertification(name: 'CPR/AED', issuer: 'Red Cross', year: 2023),
      ],
      testimonials: [
        TrainerTestimonial(
          author: 'Abebe G.',
          rating: 5.0,
          text: t(
            'As a total beginner I never felt judged — I have lost 10 kg this year.',
            'እንደ ሙሉ ጀማሪ ፈጽሞ እንደተፈረደብኝ አልተሰማኝም — በዚህ ዓመት 10 ኪግ ቀንሻለሁ።',
            'Akkuma jalqabaa guttuu akkumaan mulludha hin dhaga\'ame — waggaa kana kg 10 hir\'isee jira.',
          ),
        ),
        TrainerTestimonial(
          author: 'Chaltu B.',
          rating: 4.5,
          text: t(
            'He explains everything simply and adjusts when work gets busy.',
            'ሁሉንም ነገር በቀላሉ ይገልጻል እና ስራ ሲጨምር ያስተካክላል።',
            'Waanti hundi salphaatti ibsa, hojiin yoo baay\'u sirreessa.',
          ),
        ),
      ],
    ),
  ];

  static final events = [
    FitnessEvent(
      id: 'e1',
      title: t(
        'Saturday Morning Run',
        'የቅዳሜ ጠዋት ሩጫ',
        'Fiigicha Ganama Sanbataa',
      ),
      type: t('Run', 'ሩጫ', 'Fiigicha'),
      venue: t(
        'Meskel Square, Addis Ababa',
        'መስቀል አደባባይ፣ አዲስ አበባ',
        'Meskel Square, Finfinnee',
      ),
      dateLabel: t('Sat, 27 Sep', 'ቅዳሜ፣ መስከረም 27', 'Sanbata, Fulbaana 27'),
      timeLabel: t('7:00 AM', 'ጠዋት 7:00', 'Sa\'aatii 7 ganama'),
      attending: 104,
      description: t(
        'Easy group run for all levels. Meet at Meskel Square, 5–8 km loops with water stops.',
        'ለሁሉም ደረጃዎች ቀላል የቡድን ሩጫ። በመስቀል አደባባይ ተገናኙ፣ 5–8 ኪሜ ዙሮች ከውሃ ማቆሚያዎች ጋር።',
        'Fiigicha garee salphaa sadarkaa hundaaf. Meskel Square irratti walitti dhufaa, loopii km 5–8 fi iddoo bishaanii waliin.',
      ),
    ),
    FitnessEvent(
      id: 'e2',
      title: t(
        'Power Fitness Open Day',
        'ፓወር ፊትነስ ክፍት ቀን',
        'Guyyaa Banaa Power Fitness',
      ),
      type: t('Class', 'ክፍል', 'Daree'),
      venue: t('Power Fitness, Bole', 'ፓወር ፊትነስ፣ ቦሌ', 'Power Fitness, Boolee'),
      dateLabel: t('Sun, 28 Sep', 'እሁድ፣ መስከረም 28', 'Dilbata, Fulbaana 28'),
      timeLabel: t('10:00 AM', 'ጠዋት 10:00', 'Sa\'aatii 10 ganama'),
      attending: 56,
      description: t(
        'Trial classes, form workshops, and community check-ins. Free for first-time visitors.',
        'የሙከራ ክፍሎች፣ የቅርጽ ወርክሾፖች እና የማህበረሰብ ቼክ-ኢኖች። ለመጀመሪያ ጊዜ ጎብኚዎች ነፃ።',
        'Daree yaalii, warkishooppii foormii, fi check-in hawaasaa. Daawwattoota yeroo jalqabaaf bilisa.',
      ),
    ),
    FitnessEvent(
      id: 'e3',
      title: t('Addis Strength Meet', 'አዲስ ስትረንግዝ ሚት', 'Addis Strength Meet'),
      type: t('Competition', 'ውድድር', 'Dorgommii'),
      venue: t(
        'Prime Strength Lab, Kazanchis',
        'ፕራይም ስትረንግዝ ላብ፣ ካዛንቺስ',
        'Prime Strength Lab, Kaazaanchis',
      ),
      dateLabel: t('Sat, 4 Oct', 'ቅዳሜ፣ ጥቅምት 4', 'Sanbata, Onkoloolessa 4'),
      timeLabel: t('9:00 AM', 'ጠዋት 9:00', 'Sa\'aatii 9 ganama'),
      attending: 38,
      description: t(
        'Local powerlifting meet — squat, bench, deadlift. Spectators welcome.',
        'የአካባቢ የፓወርሊፍቲንግ ውድድር — ስኳት፣ ቤንች፣ ዴድሊፍት። ተመልካቾች እንኳን ደህና መጡ።',
        'Dorgommii paawariliifitingii naannoo — iskwaatii, beenchii, dediliiftii. Daawwattoonni simatamu.',
      ),
    ),
    FitnessEvent(
      id: 'e4',
      title: t('Nutrition Workshop', 'የአመጋገብ ወርክሾፕ', 'Warkishooppii Nyaataa'),
      type: t('Workshop', 'ወርክሾፕ', 'Warkishooppii'),
      venue: t(
        'CMC Community Hall',
        'ሲኤምሲ የማህበረሰብ አዳራሽ',
        'Haallii Hawaasaa CMC',
      ),
      dateLabel: t('Thu, 2 Oct', 'ሐሙስ፣ ጥቅምት 2', 'Kamisa, Onkoloolessa 2'),
      timeLabel: t('6:30 PM', 'ማታ 6:30', 'Sa\'aatii 6:30 galgala'),
      attending: 72,
      description: t(
        'Nutrition tips for muscle gain and fat loss with Ethiopian staples.',
        'በኢትዮጵያ ዋና ምግቦች ለጡንቻ ማሳደግ እና ስብ ማጣት የአመጋገብ ምክሮች።',
        'Gorsa nyaataa guddina maashaa fi hir\'ina dhangala\'aaf nyaata Itoophiyaa waliin.',
      ),
    ),
  ];

  static TrainerProfile? trainerById(String id) {
    for (final trainer in trainers) {
      if (trainer.id == id) return trainer;
    }
    return null;
  }

  static FitnessEvent? eventById(String id) {
    for (final e in events) {
      if (e.id == id) return e;
    }
    return null;
  }

  static final recentActivity = [
    ActivityEntry(
      title: t('Push Day', 'ፑሽ ቀን', 'Guyyaa Pushii'),
      subtitle: t('54 min · 23 sets', '54 ደቂቃ · 23 ሴትስ', 'Daqiiqaa 54 · setii 23'),
      xp: 180,
      dateLabel: t('Yesterday', 'ትናንት', 'Kaleessa'),
    ),
    ActivityEntry(
      title: t(
        'Checked in · Power Fitness',
        'ቼክ-ኢን · ፓወር ፊትነስ',
        'Check-in · Power Fitness',
      ),
      subtitle: t('Evening session', 'የማታ ክፍለ ጊዜ', 'Seshinii galgalaa'),
      xp: 25,
      dateLabel: t('Yesterday', 'ትናንት', 'Kaleessa'),
    ),
    ActivityEntry(
      title: t('Legs & Core', 'እግሮች እና ኮር', 'Miila & Kooree'),
      subtitle: t('48 min · 19 sets', '48 ደቂቃ · 19 ሴትስ', 'Daqiiqaa 48 · setii 19'),
      xp: 160,
      dateLabel: t('Wed', 'ረቡዕ', 'Roobii'),
    ),
    ActivityEntry(
      title: t(
        'Consistency streak',
        'ተከታታይነት',
        'Walitti fufiinsa',
      ),
      subtitle: t(
        '6 / 7 training days this week',
        'በዚህ ሳምንት 6 / 7 የስልጠና ቀናት',
        'Guyyaa leenjii 6 / 7 torbee kana',
      ),
      xp: 40,
      dateLabel: t('Tue', 'ማክሰኞ', 'Kibxata'),
    ),
  ];

  static WorkoutPlan? workoutById(String id) {
    for (final w in recommendedWorkouts) {
      if (w.id == id) return w;
    }
    return null;
  }

  static GymPlace? gymById(String id) {
    for (final g in gyms) {
      if (g.id == id) return g;
    }
    return null;
  }

  static ChallengeInfo? challengeById(String id) {
    for (final c in challenges) {
      if (c.id == id) return c;
    }
    return null;
  }

  static FriendStatus? friendByName(String name) {
    for (final f in friends) {
      if (f.name == name) return f;
    }
    return null;
  }

  static FeedPost? feedPostById(String id) {
    for (final p in feed) {
      if (p.id == id) return p;
    }
    return null;
  }

  static FriendWorkoutSession? workoutSessionById(String id) {
    for (final s in friendWorkouts) {
      if (s.id == id) return s;
    }
    return null;
  }

  static List<FriendWorkoutSession> workoutsForFriend(String name) {
    final list = friendWorkouts.where((s) => s.friendName == name).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }
}
