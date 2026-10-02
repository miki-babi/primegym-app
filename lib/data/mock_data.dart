import '../l10n/localized_string.dart';
import '../models/models.dart';
import 'exercise_images.dart';
import 'exercise_videos.dart';
import 'user_preferences.dart';

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

  static final exercises = [
    ExerciseItem(
      id: 'ex1',
      imageAsset: ExerciseImages.forId('ex1'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex1'),
      name: t('Barbell Bench Press', 'ባርቤል ቤንች ፕረስ', 'Baarbeelii Beenchii Presse'),
      muscle: t('Chest', 'ደረት', 'Qoma'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Barbell', 'ባርቤል', 'Baarbeelii'),
      instructions: t(
        'Lie on a flat bench, grip the bar slightly wider than shoulders, lower to mid-chest, then press up.',
        'በጠፍጣፋ ቤንች ላይ ተኛ፣ ባሩን ከትከሻ በትንሹ ሰፋ ብለህ ያዝ፣ ወደ መካከለኛ ደረት አውርድ፣ ከዚያ ወደ ላይ ጫን።',
        'Beenchii dirree irratti ciisi, baarbeelii gurruu caalaa bal\'inaan qabi, gara qoma giddugaleessaa gadi buusi, sana booda ol dhiibi.',
      ),
      commonMistakes: t(
        'Bouncing the bar off the chest, flaring elbows too wide, or lifting hips off the bench.',
        'ባሩን በደረት ላይ መምታት፣ ክርኖችን በጣም ማስፋት፣ ወይም ዳሌን ከቤንቹ ማንሳት።',
        'Baarbeelii qoma irratti dha\'uu, ciboota baay\'ee bal\'isuu, ykn qaama beenchii irraa kaasuun.',
      ),
      secondaryMuscles: [
        t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
        t('Shoulders', 'ትከሻዎች', 'Gurruu'),
      ],
    ),
    ExerciseItem(
      id: 'ex2',
      imageAsset: ExerciseImages.forId('ex2'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex2'),
      name: t(
        'Incline Dumbbell Press',
        'ኢንክላይን ዳምቤል ፕረስ',
        'Inkilaayin Daambelii Presse',
      ),
      muscle: t('Chest', 'ደረት', 'Qoma'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
      instructions: t(
        'Set the bench to a mild incline, press dumbbells from chest level to lockout overhead.',
        'ቤንቹን ቀላል ቁልቁለት አድርግ፣ ዳምቤሎቹን ከደረት ደረጃ እስከ ሙሉ ስፋት ድረስ ጫን።',
        'Beenchii ol ka\'insa salphaa ta\'e irratti qophiessi, daambeloota sadarkaa qomaa irraa ol dhiibi.',
      ),
      commonMistakes: t(
        'Using too steep an incline or letting dumbbells drift too far forward.',
        'በጣም ቁልቁለት መጠቀም ወይም ዳምቤሎቹን ወደ ፊት ማስገባት።',
        'Ol ka\'insa baay\'ee guddaa fayyadamuu ykn daambeloota fuulduraatti darbuu.',
      ),
      secondaryMuscles: [t('Shoulders', 'ትከሻዎች', 'Gurruu')],
    ),
    ExerciseItem(
      id: 'ex3',
      imageAsset: ExerciseImages.forId('ex3'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex3'),
      name: t('Cable Fly', 'ኬብል ፍላይ', 'Keebilii Flaayii'),
      muscle: t('Chest', 'ደረት', 'Qoma'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Cable', 'ኬብል', 'Keebilii'),
      instructions: t(
        'Stand between cable stacks, bring handles together in a wide arc with a soft elbow bend.',
        'በኬብል ማሽኖች መካከል ቁም፣ እጀታዎቹን በሰፊ ቅስት በቀላል የክርን መታጠፍ አንድ ላይ አምጣ።',
        'Gidduu maashinii keebilii dhaabadhu, harkaa keebilii arcii bal\'aa fi ciboo laaffaa waliin walitti fidee.',
      ),
      commonMistakes: t(
        'Locking elbows straight or using too much momentum.',
        'ክርኖችን ሙሉ በሙሉ ማስተካከል ወይም በፍጥነት መጎተት።',
        'Ciboota guutummaa diriirsuu ykn saffisa baay\'een harkisuu.',
      ),
    ),
    ExerciseItem(
      id: 'ex4',
      imageAsset: ExerciseImages.forId('ex4'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex4'),
      name: t('Tricep Pushdown', 'ትራይሴፕ ፑሽዳውን', 'Tiraayseepsii Pushidaawnii'),
      muscle: t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Cable', 'ኬብል', 'Keebilii'),
      instructions: t(
        'Keep elbows pinned to your sides and push the cable attachment down until arms straighten.',
        'ክርኖችህን በጎንህ አጣብቅ፣ ኬብሉን ወደ ታች ጫን እስከ እጆችህ እስኪስተካከሉ ድረስ።',
        'Ciboota cinaacha keetti qabi, keebilii gadi dhiibi hanga harkoonni diriiranitti.',
      ),
      commonMistakes: t(
        'Letting elbows flare forward or shrugging the shoulders.',
        'ክርኖችን ወደ ፊት ማስገባት ወይም ትከሻዎችን ማንሳት።',
        'Ciboota fuulduraatti fiduu ykn gurruu ol kaasuun.',
      ),
    ),
    ExerciseItem(
      id: 'ex5',
      imageAsset: ExerciseImages.forId('ex5'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex5'),
      name: t('Overhead Extension', 'ኦቨርሄድ ኤክስቴንሽን', 'Overheedii Eksiteenshinii'),
      muscle: t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
      instructions: t(
        'Hold a dumbbell overhead, lower it behind the head by bending elbows, then extend.',
        'ዳምቤልን ከራስ በላይ ያዝ፣ በክርን በማጠፍ ከጭንቅላት በስተጀርባ አውርድ፣ ከዚያ ዘርጋ።',
        'Daambelii mataa olitti qabi, ciboota qabxiisuun mataa duubaatti buusi, sana booda diriirsi.',
      ),
      commonMistakes: t(
        'Flaring elbows outward or arching the lower back heavily.',
        'ክርኖችን ወደ ውጭ ማስፋት ወይም የታችኛውን ጀርባ በጣም ማጎብጠት።',
        'Ciboota alatti bal\'isuu ykn dugda gadii baay\'ee qabxiisuu.',
      ),
    ),
    ExerciseItem(
      id: 'ex6',
      imageAsset: ExerciseImages.forId('ex6'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex6'),
      name: t('Lateral Raise', 'ላተራል ሬይዝ', 'Laateeraalii Reezii'),
      muscle: t('Shoulders', 'ትከሻዎች', 'Gurruu'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
      instructions: t(
        'Raise dumbbells out to the sides until arms reach about shoulder height, then lower slowly.',
        'ዳምቤሎቹን ወደ ጎን አንሳ እስከ ትከሻ ደረጃ ድረስ፣ ከዚያ ቀስ ብለህ አውርድ።',
        'Daambeloota cinaachaatti ol kaasi hanga sadarkaa gurruutti, sana booda suuta gadi buusi.',
      ),
      commonMistakes: t(
        'Swinging the weights or raising above ear height with momentum.',
        'ክብደቶቹን ማወዛወዝ ወይም ከጆሮ በላይ በፍጥነት ማንሳት።',
        'Ulfaatina sochoosuu ykn gurra olitti saffisaan kaasuun.',
      ),
    ),
    ExerciseItem(
      id: 'ex7',
      imageAsset: ExerciseImages.forId('ex7'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex7'),
      name: t('Push-up', 'ፑሽ አፕ', 'Push-aapii'),
      muscle: t('Chest', 'ደረት', 'Qoma'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Bodyweight', 'የሰውነት ክብደት', 'Ulfaatina qaamaa'),
      instructions: t(
        'Keep a straight body line, lower chest toward the floor, then press back up.',
        'ሰውነትህን ቀጥ አድርግ፣ ደረትህን ወደ መሬት አውርድ፣ ከዚያ ወደ ላይ ጫን።',
        'Qaama kee qajeelchi, qoma gara lafaatti buusi, sana booda ol dhiibi.',
      ),
      commonMistakes: t(
        'Sagging hips, flared elbows, or incomplete range of motion.',
        'ዳሌን ማንጠልጠል፣ ክርኖችን ማስፋት፣ ወይም ሙሉ እንቅስቃሴ አለማድረግ።',
        'Qaama gadi lollisuu, ciboota bal\'isuu, ykn sochii guutuu hin gochuun.',
      ),
    ),
    ExerciseItem(
      id: 'ex8',
      imageAsset: ExerciseImages.forId('ex8'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex8'),
      name: t('Barbell Row', 'ባርቤል ሮው', 'Baarbeelii Roowii'),
      muscle: t('Back', 'ጀርባ', 'Dugda'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Barbell', 'ባርቤል', 'Baarbeelii'),
      instructions: t(
        'Hinge at the hips, pull the bar to the lower ribcage, and squeeze the shoulder blades.',
        'በዳሌ ተጣፍ፣ ባሩን ወደ ታችኛው የጎድን አጥንት ጎትት፣ የትከሻ ምላጭህን አጣብቅ።',
        'Qaama qabxiisi, baarbeelii gara lafee cinaachaa gadiitti harkisi, daapha gurruu walitti qabi.',
      ),
      commonMistakes: t(
        'Rounding the back or yanking the bar with momentum.',
        'ጀርባን ማጎብጠት ወይም ባሩን በፍጥነት መጎተት።',
        'Dugda qabxiisuu ykn baarbeelii saffisaan harkisuu.',
      ),
      secondaryMuscles: [t('Biceps', 'ባይሴፕስ', 'Baayseepsii')],
    ),
    ExerciseItem(
      id: 'ex9',
      imageAsset: ExerciseImages.forId('ex9'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex9'),
      name: t('Lat Pulldown', 'ላት ፑልዳውን', 'Laatii Pulidaawnii'),
      muscle: t('Back', 'ጀርባ', 'Dugda'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Cable', 'ኬብል', 'Keebilii'),
      instructions: t(
        'Pull the bar to the upper chest while keeping your torso upright and elbows driving down.',
        'አካልህን ቀጥ አድርገህ ባሩን ወደ ላይኛው ደረት ጎትት፣ ክርኖችህን ወደ ታች መራ።',
        'Qaama kee qajeesseettaan baarbeelii gara qoma olitti harkisi, ciboota gadi oofuu.',
      ),
      commonMistakes: t(
        'Leaning too far back or pulling behind the neck.',
        'በጣም ወደ ኋላ ማጋደል ወይም ከአንገት በስተጀርባ መጎተት።',
        'Duubaatti baay\'ee gadi jedhuu ykn morma duubaatti harkisuu.',
      ),
      secondaryMuscles: [t('Biceps', 'ባይሴፕስ', 'Baayseepsii')],
    ),
    ExerciseItem(
      id: 'ex10',
      imageAsset: ExerciseImages.forId('ex10'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex10'),
      name: t('Dumbbell Curl', 'ዳምቤል ኬርል', 'Daambelii Keerlii'),
      muscle: t('Arms', 'እጆች', 'Harka'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
      instructions: t(
        'Keep elbows close to your sides and curl the dumbbells up without swinging.',
        'ክርኖችህን በጎንህ አቆይ፣ ዳምቤሎቹን ሳታወዛውዝ ወደ ላይ ጎትት።',
        'Ciboota cinaacha keetti qabi, daambeloota osoo hin sochoosin ol harkisi.',
      ),
      commonMistakes: t(
        'Swinging the torso or moving the elbows forward.',
        'አካልን ማወዛወዝ ወይም ክርኖችን ወደ ፊት ማንቀሳቀስ።',
        'Qaama sochoosuu ykn ciboota fuulduraatti sochoosuu.',
      ),
    ),
    ExerciseItem(
      id: 'ex11',
      imageAsset: ExerciseImages.forId('ex11'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex11'),
      name: t('Back Squat', 'ባክ ስኳት', 'Baakii Iskwaatii'),
      muscle: t('Legs', 'እግሮች', 'Miila'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Barbell', 'ባርቤል', 'Baarbeelii'),
      instructions: t(
        'Brace your core, sit the hips back and down, keep chest up, then drive through the mid-foot.',
        'ኮርህን አጣብቅ፣ ዳሌህን ወደ ኋላና ታች አስቀምጥ፣ ደረትህን አንሳ፣ በመሃል እግር ጫን።',
        'Kooree kee jabeessi, qaama duuba fi gadi teessisi, qoma ol kaasi, miila giddugaleessaan dhiibi.',
      ),
      commonMistakes: t(
        'Knees collapsing inward or rounding the upper back under the bar.',
        'ጉልበቶች ወደ ውስጥ መውደቅ ወይም የላይኛው ጀርባ ማጎብጠት።',
        'Jilba keessatti kufuu ykn dugda olii qabxiisuu.',
      ),
      secondaryMuscles: [
        t('Glutes', 'ቂጣ', 'Fudhaa'),
        t('Core', 'ኮር', 'Kooree'),
      ],
    ),
    ExerciseItem(
      id: 'ex12',
      imageAsset: ExerciseImages.forId('ex12'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex12'),
      name: t('Romanian Deadlift', 'ሮማኒያን ዴድሊፍት', 'Roomaaniyaan Dediliiftii'),
      muscle: t('Legs', 'እግሮች', 'Miila'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Barbell', 'ባርቤል', 'Baarbeelii'),
      instructions: t(
        'Push hips back with a soft knee bend, lower the bar along the thighs, then return upright.',
        'ጉልበት ቀላል በማጠፍ ዳሌን ወደ ኋላ ጫን፣ ባሩን በጭን ላይ አውርድ፣ ከዚያ ቀጥ በል።',
        'Jilba laaffaa ta\'een qaama duubaatti dhiibi, baarbeelii lukkuu irratti gadi buusi, sana booda qajeeli.',
      ),
      commonMistakes: t(
        'Rounding the spine or turning it into a squat by bending the knees too much.',
        'አከርካሪን ማጎብጠት ወይም ጉልበቶችን በጣም በማጠፍ ወደ ስኳት መቀየር።',
        'Lafee dugdaa qabxiisuu ykn jilba baay\'ee qabxiisuun gara iskwaatii jijjiiruu.',
      ),
      secondaryMuscles: [
        t('Back', 'ጀርባ', 'Dugda'),
        t('Glutes', 'ቂጣ', 'Fudhaa'),
      ],
    ),
    ExerciseItem(
      id: 'ex13',
      imageAsset: ExerciseImages.forId('ex13'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex13'),
      name: t('Walking Lunge', 'ዋኪንግ ለንጅ', 'Waalkingii Lenjii'),
      muscle: t('Legs', 'እግሮች', 'Miila'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Dumbbells', 'ዳምቤሎች', 'Daambeloota'),
      instructions: t(
        'Step forward into a lunge, lower the back knee, then drive up into the next step.',
        'ወደ ፊት እርምጃ ውሰድ፣ የኋላ ጉልበት አውርድ፣ ከዚያ ወደ ቀጣዩ እርምጃ ተነሳ።',
        'Fuulduraatti tarkaanfadhu, jilba duubaa gadi buusi, sana booda tarkaanfii itti aanutti ka\'i.',
      ),
      commonMistakes: t(
        'Taking tiny steps or letting the front knee cave inward.',
        'ትንንሽ እርምጃዎች መውሰድ ወይም የፊት ጉልበት ወደ ውስጥ መውደቅ።',
        'Tarkaanfii xixiqqoo fudhachuu ykn jilba duraa keessatti kufuu.',
      ),
    ),
    ExerciseItem(
      id: 'ex14',
      imageAsset: ExerciseImages.forId('ex14'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex14'),
      name: t('Overhead Press', 'ኦቨርሄድ ፕረስ', 'Overheedii Presse'),
      muscle: t('Shoulders', 'ትከሻዎች', 'Gurruu'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      equipment: t('Barbell', 'ባርቤል', 'Baarbeelii'),
      instructions: t(
        'Brace your core and press the bar from the shoulders to full lockout overhead.',
        'ኮርህን አጣብቅ፣ ባሩን ከትከሻ እስከ ሙሉ ስፋት ከራስ በላይ ጫን።',
        'Kooree kee jabeessi, baarbeelii gurruu irraa mataa oliitti guutummaa diriirsuun dhiibi.',
      ),
      commonMistakes: t(
        'Excessive lower-back arch or pressing the bar forward instead of up.',
        'የታችኛው ጀርባ በጣም ማጎብጠት ወይም ባሩን ወደ ፊት መጫን።',
        'Dugda gadii baay\'ee qabxiisuu ykn baarbeelii ol utuu hin taane fuulduraatti dhiibuu.',
      ),
      secondaryMuscles: [t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii')],
    ),
    ExerciseItem(
      id: 'ex15',
      imageAsset: ExerciseImages.forId('ex15'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex15'),
      name: t('Face Pull', 'ፌስ ፑል', 'Feesii Pulii'),
      muscle: t('Shoulders', 'ትከሻዎች', 'Gurruu'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Cable', 'ኬብል', 'Keebilii'),
      instructions: t(
        'Pull the rope toward your face, externally rotating so hands finish near the ears.',
        'ገመዱን ወደ ፊትህ ጎትት፣ እጆችህ አጠገብ ጆሮ እንዲደርሱ በማድረግ አሽከርክር።',
        'Funyoo gara fuula keetti harkisi, harkoonni gara gurraatti akka dhufanitti naannessi.',
      ),
      commonMistakes: t(
        'Using too much weight and turning it into a row without rotation.',
        'በጣም ክብደት መጠቀም እና ያለ ማሽከርከር ወደ ሮው መቀየር።',
        'Ulfaatina baay\'ee fayyadamuu fi osoo hin naannessin gara roowii jijjiiruu.',
      ),
    ),
    ExerciseItem(
      id: 'ex16',
      imageAsset: ExerciseImages.forId('ex16'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex16'),
      name: t('Bodyweight Squat', 'የሰውነት ክብደት ስኳት', 'Iskwaatii ulfaatina qaamaa'),
      muscle: t('Legs', 'እግሮች', 'Miila'),
      type: t('Compound', 'ውህድ', 'Walitti makaa'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Bodyweight', 'የሰውነት ክብደት', 'Ulfaatina qaamaa'),
      instructions: t(
        'Stand with feet shoulder-width, sit hips back and down, then drive up through the heels.',
        'እግሮችን በትከሻ ስፋት አድርግ፣ ዳሌን ወደ ኋላና ታች አውርድ፣ ከዚያ በተረከዝ ተነሳ።',
        'Miila bal\'ina gurruu ta\'eetti dhaabadhu, qaama duubaafi gadiitti buusi, sana booda dugda miilaan ka\'i.',
      ),
      commonMistakes: t(
        'Knees caving inward or lifting heels off the floor.',
        'ጉልበቶች ወደ ውስጥ መውደቅ ወይም ተረከዝ ከመሬት ማንሳት።',
        'Jilba keessatti kufuu ykn dugda miilaa lafa irraa kaasuun.',
      ),
      secondaryMuscles: [t('Glutes', 'ቂጣ', 'Fudhaa')],
    ),
    ExerciseItem(
      id: 'ex17',
      imageAsset: ExerciseImages.forId('ex17'),
      youtubeVideoId: ExerciseVideos.forExerciseId('ex17'),
      name: t('Plank', 'ፕላንክ', 'Pilaankii'),
      muscle: t('Core', 'ኮር', 'Kooree'),
      type: t('Isolation', 'ነጠላ', 'Addaan baasuu'),
      difficulty: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      equipment: t('Bodyweight', 'የሰውነት ክብደት', 'Ulfaatina qaamaa'),
      instructions: t(
        'Hold a straight body line on forearms and toes, bracing the core without letting hips sag.',
        'በክንድ እና ጣቶች ላይ ቀጥ ያለ የሰውነት መስመር አቆይ፣ ዳሌ ሳይወድቅ ኮርህን አጣብቅ።',
        'Harkaafi quba miilaa irratti sarara qaamaa qajeelaa eegi, qaama utuu hin lollisiin kooree jabeessi.',
      ),
      commonMistakes: t(
        'Hips sagging toward the floor or hiking too high.',
        'ዳሌ ወደ መሬት መውደቅ ወይም በጣም ከፍ ማድረግ።',
        'Qaama gara lafaatti lollisuu ykn baay\'ee ol kaasuu.',
      ),
    ),
  ];

  static WorkoutPlan get todaysWorkout => WorkoutPlan(
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
        exercises: [
          WorkoutExercise(exercise: exercises[0], sets: 4, reps: 8, weightKg: 80),
          WorkoutExercise(exercise: exercises[1], sets: 3, reps: 10, weightKg: 28),
          WorkoutExercise(exercise: exercises[2], sets: 3, reps: 12, weightKg: 20),
          WorkoutExercise(exercise: exercises[5], sets: 3, reps: 12, weightKg: 10),
          WorkoutExercise(exercise: exercises[3], sets: 3, reps: 12, weightKg: 25),
          WorkoutExercise(exercise: exercises[4], sets: 3, reps: 10, weightKg: 16),
          WorkoutExercise(exercise: exercises[6], sets: 2, reps: 15, weightKg: 0),
        ],
      );

  static final recommendedWorkouts = [
    todaysWorkout,
    WorkoutPlan(
      id: 'w2',
      title: t('Push Day', 'ፑሽ ቀን', 'Guyyaa Pushii'),
      durationMinutes: 45,
      level: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      muscles: [
        t('Chest', 'ደረት', 'Qoma'),
        t('Shoulders', 'ትከሻዎች', 'Gurruu'),
        t('Triceps', 'ትራይሴፕስ', 'Tiraayseepsii'),
      ],
      owner: 'Abel',
      tag: t('Popular', 'ታዋቂ', 'Beekamaa'),
      exercises: todaysWorkout.exercises,
    ),
    WorkoutPlan(
      id: 'w5',
      title: t('Back + Biceps', 'ጀርባ + ባይሴፕስ', 'Dugda + Baayseepsii'),
      durationMinutes: 50,
      level: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      muscles: [
        t('Back', 'ጀርባ', 'Dugda'),
        t('Arms', 'እጆች', 'Harka'),
      ],
      owner: 'Hana',
      tag: t('Pull', 'ፑል', 'Pulii'),
      exercises: [
        WorkoutExercise(exercise: exercises[7], sets: 4, reps: 8, weightKg: 70),
        WorkoutExercise(exercise: exercises[8], sets: 3, reps: 10, weightKg: 45),
        WorkoutExercise(exercise: exercises[9], sets: 3, reps: 12, weightKg: 14),
      ],
    ),
    WorkoutPlan(
      id: 'w6',
      title: t('Legs Day', 'የእግር ቀን', 'Guyyaa Miilaa'),
      durationMinutes: 55,
      level: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      muscles: [t('Legs', 'እግሮች', 'Miila')],
      owner: 'Dawit',
      tag: t('Lower', 'ታችኛ', 'Gadii'),
      exercises: [
        WorkoutExercise(exercise: exercises[10], sets: 4, reps: 6, weightKg: 100),
        WorkoutExercise(exercise: exercises[11], sets: 3, reps: 8, weightKg: 80),
        WorkoutExercise(exercise: exercises[12], sets: 3, reps: 10, weightKg: 20),
      ],
    ),
    WorkoutPlan(
      id: 'w7',
      title: t('Shoulders Focus', 'ትኩረት ትከሻ', 'Xiyyeeffannoo Gurruu'),
      durationMinutes: 35,
      level: t('Intermediate', 'መካከለኛ', 'Giddugaleessa'),
      muscles: [t('Shoulders', 'ትከሻዎች', 'Gurruu')],
      owner: 'Sara',
      tag: t('Focus', 'ትኩረት', 'Xiyyeeffannoo'),
      exercises: [
        WorkoutExercise(exercise: exercises[13], sets: 4, reps: 8, weightKg: 40),
        WorkoutExercise(exercise: exercises[5], sets: 3, reps: 12, weightKg: 10),
        WorkoutExercise(exercise: exercises[14], sets: 3, reps: 15, weightKg: 20),
      ],
    ),
    WorkoutPlan(
      id: 'w3',
      title: t('Home Full Body', 'በቤት ሙሉ አካል', 'Manaa Qaama Guutuu'),
      durationMinutes: 30,
      level: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      muscles: [t('Full body', 'ሙሉ አካል', 'Qaama guutuu')],
      owner: currentUser,
      tag: t('Home', 'ቤት', 'Mana'),
      exercises: [
        WorkoutExercise(exercise: exercises[6], sets: 3, reps: 12, weightKg: 0),
        WorkoutExercise(exercise: exercises[5], sets: 3, reps: 12, weightKg: 8),
        WorkoutExercise(exercise: exercises[12], sets: 3, reps: 10, weightKg: 12),
        WorkoutExercise(exercise: exercises[4], sets: 3, reps: 12, weightKg: 10),
      ],
    ),
    WorkoutPlan(
      id: 'w4',
      title: t('15-Min Burn', '15 ደቂቃ ማቃጠል', 'Gubuu Daqiiqaa 15'),
      durationMinutes: 15,
      level: t('Beginner', 'ጀማሪ', 'Jalqabaa'),
      muscles: [
        t('Full body', 'ሙሉ አካል', 'Qaama guutuu'),
        t('Cardio', 'ካርዲዮ', 'Kaardiyoo'),
      ],
      owner: 'Abel',
      tag: t('Quick', 'ፈጣን', 'Saffisaa'),
      exercises: [
        WorkoutExercise(exercise: exercises[6], sets: 4, reps: 20, weightKg: 0),
        WorkoutExercise(exercise: exercises[15], sets: 3, reps: 15, weightKg: 0),
        WorkoutExercise(exercise: exercises[16], sets: 3, reps: 40, weightKg: 0),
      ],
    ),
  ];

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

  static bool exerciseMatchesEnvironment(
    ExerciseItem exercise,
    TrainingEnvironment environment,
  ) {
    final equipment = exercise.equipment.en;
    return switch (environment) {
      TrainingEnvironment.noEquipment => equipment == 'Bodyweight',
      TrainingEnvironment.home =>
        equipment == 'Bodyweight' || equipment == 'Dumbbells',
      TrainingEnvironment.gym => true,
    };
  }

  static bool exerciseMatchesEnvironments(
    ExerciseItem exercise,
    Set<TrainingEnvironment> environments,
  ) {
    if (environments.isEmpty) return true;
    return environments.any(
      (env) => exerciseMatchesEnvironment(exercise, env),
    );
  }

  static bool workoutMatchesEnvironments(
    WorkoutPlan workout,
    Set<TrainingEnvironment> environments,
  ) {
    if (workout.exercises.isEmpty) return false;
    return workout.exercises.every(
      (we) => exerciseMatchesEnvironments(we.exercise, environments),
    );
  }

  static List<WorkoutPlan> workoutsForEnvironments(
    Set<TrainingEnvironment> environments,
  ) {
    return recommendedWorkouts
        .where((w) => workoutMatchesEnvironments(w, environments))
        .toList();
  }

  static List<ExerciseItem> exercisesForEnvironments(
    Set<TrainingEnvironment> environments,
  ) {
    return exercises
        .where((e) => exerciseMatchesEnvironments(e, environments))
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
      programs: [
        t('Desk Athlete Reset', 'የቢሮ አትሌት ዳግም ማስጀመር', 'Resetii Atileetii Deeskii'),
        t(
          'Joint-Friendly Strength',
          'ለመገጣጠሚያ ተስማሚ ጥንካሬ',
          'Cimina Mijataa Gidduu',
        ),
        t('Posture & Core', 'አቋም እና ኮር', 'Haala Qaamaa & Kooree'),
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
      programs: [
        t('Snatch Foundations', 'የስናች መሠረቶች', 'Bu\'uura Snaachii'),
        t('Clean & Jerk Cycle', 'ክሊን እና ጀርክ ዑደት', 'Saaykilii Kiliin & Jerk'),
        t('Competition Prep', 'የውድድር ዝግጅት', 'Qophii Dorgommii'),
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

  static ExerciseItem? exerciseById(String id) {
    for (final e in exercises) {
      if (e.id == id) return e;
    }
    return null;
  }
}
