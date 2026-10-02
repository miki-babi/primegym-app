/// Curated real YouTube form-demo video IDs (public exercise tutorials).
abstract final class ExerciseVideos {
  // Verified public form tutorials (Athlean-X / Scott Herman Fitness).
  static const benchPress = 'vthMCtgVtFw'; // How to Bench Press
  static const inclineDbPress = '8iPEnn-ltC8'; // Incline Dumbbell Press
  static const cableFly = 'Iwe6AmxVf7o'; // Cable Flye
  static const tricepPushdown = '2-LaAJqA2ho'; // Tricep Pushdown
  static const overheadExtension = 'YbX7Wd8jQ-g'; // Overhead Extension
  static const lateralRaise = '3VcKaXpzqRo'; // Lateral Raise
  static const pushUp = 'IODxDxX7oiE'; // Perfect Push Up
  static const barbellRow = 'vT2GjY_Umpw'; // Barbell Row
  static const latPulldown = 'CAwf7n6Luuc'; // Lat Pulldown
  static const dumbbellCurl = 'ykJmrZ5v0Oo'; // Dumbbell Curl
  static const backSquat = 'ultWZbUMPL8'; // How to Squat
  static const romanianDeadlift = 'jEy_czb3RKA'; // Romanian Deadlift
  static const walkingLunge = 'L8fvypPrzzs'; // Walking Lunges
  static const overheadPress = '2yjwXTZQDDI'; // Overhead Press
  static const facePull = 'rep-U4S8rk0'; // Face Pull
  static const bodyweightSquat = 'ultWZbUMPL8'; // How to Squat
  static const plank = 'ASdvN_XEl_c'; // Plank form

  static String forExerciseId(String id) => switch (id) {
        'ex1' => benchPress,
        'ex2' => inclineDbPress,
        'ex3' => cableFly,
        'ex4' => tricepPushdown,
        'ex5' => overheadExtension,
        'ex6' => lateralRaise,
        'ex7' => pushUp,
        'ex8' => barbellRow,
        'ex9' => latPulldown,
        'ex10' => dumbbellCurl,
        'ex11' => backSquat,
        'ex12' => romanianDeadlift,
        'ex13' => walkingLunge,
        'ex14' => overheadPress,
        'ex15' => facePull,
        'ex16' => bodyweightSquat,
        'ex17' => plank,
        _ => benchPress,
      };
}
