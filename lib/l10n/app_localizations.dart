import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get navCommunity;

  /// No description provided for @navActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navActivity;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingEnterHome.
  ///
  /// In en, this message translates to:
  /// **'Enter home'**
  String get onboardingEnterHome;

  /// No description provided for @onboardingChooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboardingChooseLanguageTitle;

  /// No description provided for @onboardingChooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in settings.'**
  String get onboardingChooseLanguageSubtitle;

  /// No description provided for @onboardingEquipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Where will you train?'**
  String get onboardingEquipmentTitle;

  /// No description provided for @onboardingEquipmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick one or more places — we\'ll tailor exercises to your gear.'**
  String get onboardingEquipmentSubtitle;

  /// No description provided for @equipmentNoEquipment.
  ///
  /// In en, this message translates to:
  /// **'No equipment'**
  String get equipmentNoEquipment;

  /// No description provided for @equipmentNoEquipmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight workouts, anywhere'**
  String get equipmentNoEquipmentDesc;

  /// No description provided for @equipmentNoEquipmentDetail.
  ///
  /// In en, this message translates to:
  /// **'Train with just your body — push-ups, squats, planks, and core work. Ideal for travel, parks, or zero-gear days.'**
  String get equipmentNoEquipmentDetail;

  /// No description provided for @equipmentNoEquipmentHighlight1.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight only'**
  String get equipmentNoEquipmentHighlight1;

  /// No description provided for @equipmentNoEquipmentHighlight2.
  ///
  /// In en, this message translates to:
  /// **'Train anywhere'**
  String get equipmentNoEquipmentHighlight2;

  /// No description provided for @equipmentNoEquipmentHighlight3.
  ///
  /// In en, this message translates to:
  /// **'No gear needed'**
  String get equipmentNoEquipmentHighlight3;

  /// No description provided for @equipmentHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get equipmentHome;

  /// No description provided for @equipmentHomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Dumbbells, bands, or home equipment'**
  String get equipmentHomeDesc;

  /// No description provided for @equipmentHomeDetail.
  ///
  /// In en, this message translates to:
  /// **'Use dumbbells, bands, or whatever you keep at home. We\'ll skip gym machines and cables so every move fits your space.'**
  String get equipmentHomeDetail;

  /// No description provided for @equipmentHomeHighlight1.
  ///
  /// In en, this message translates to:
  /// **'Dumbbells'**
  String get equipmentHomeHighlight1;

  /// No description provided for @equipmentHomeHighlight2.
  ///
  /// In en, this message translates to:
  /// **'Bands'**
  String get equipmentHomeHighlight2;

  /// No description provided for @equipmentHomeHighlight3.
  ///
  /// In en, this message translates to:
  /// **'Home gear'**
  String get equipmentHomeHighlight3;

  /// No description provided for @equipmentGym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get equipmentGym;

  /// No description provided for @equipmentGymDesc.
  ///
  /// In en, this message translates to:
  /// **'Machines, barbells, cables, and full equipment'**
  String get equipmentGymDesc;

  /// No description provided for @equipmentGymDetail.
  ///
  /// In en, this message translates to:
  /// **'Full access to machines, barbells, cables, and racks. Get complete strength plans built for a real gym floor.'**
  String get equipmentGymDetail;

  /// No description provided for @equipmentGymHighlight1.
  ///
  /// In en, this message translates to:
  /// **'Machines'**
  String get equipmentGymHighlight1;

  /// No description provided for @equipmentGymHighlight2.
  ///
  /// In en, this message translates to:
  /// **'Barbells'**
  String get equipmentGymHighlight2;

  /// No description provided for @equipmentGymHighlight3.
  ///
  /// In en, this message translates to:
  /// **'Cables'**
  String get equipmentGymHighlight3;

  /// No description provided for @settingsTrainingEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Training environment'**
  String get settingsTrainingEnvironment;

  /// No description provided for @onboardingWelcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get onboardingWelcomeHeadline;

  /// No description provided for @onboardingWelcomeAccent.
  ///
  /// In en, this message translates to:
  /// **'PrimeGym'**
  String get onboardingWelcomeAccent;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Train smarter, eat better, and grow with community across Addis.'**
  String get onboardingWelcomeBody;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageAmharic.
  ///
  /// In en, this message translates to:
  /// **'አማርኛ (Amharic)'**
  String get languageAmharic;

  /// No description provided for @languageAfaanOromoo.
  ///
  /// In en, this message translates to:
  /// **'Afaan Oromoo'**
  String get languageAfaanOromoo;

  /// No description provided for @goalBuildMuscle.
  ///
  /// In en, this message translates to:
  /// **'Build muscle'**
  String get goalBuildMuscle;

  /// No description provided for @goalLoseFat.
  ///
  /// In en, this message translates to:
  /// **'Lose fat'**
  String get goalLoseFat;

  /// No description provided for @goalGainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get goalGainWeight;

  /// No description provided for @goalMaintain.
  ///
  /// In en, this message translates to:
  /// **'Maintain'**
  String get goalMaintain;

  /// No description provided for @goalImproveStrength.
  ///
  /// In en, this message translates to:
  /// **'Improve strength'**
  String get goalImproveStrength;

  /// No description provided for @goalImproveFitness.
  ///
  /// In en, this message translates to:
  /// **'Improve fitness'**
  String get goalImproveFitness;

  /// No description provided for @goalImproveEndurance.
  ///
  /// In en, this message translates to:
  /// **'Improve endurance'**
  String get goalImproveEndurance;

  /// No description provided for @goalGeneralHealth.
  ///
  /// In en, this message translates to:
  /// **'General health'**
  String get goalGeneralHealth;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @levelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvanced;

  /// No description provided for @onboardingPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to train'**
  String get onboardingPlanTitle;

  /// No description provided for @onboardingPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Here\'s your personalized PrimeGym setup.'**
  String get onboardingPlanSubtitle;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @greetingWithName.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {name} 👋'**
  String greetingWithName(String greeting, String name);

  /// No description provided for @dayStreak.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String dayStreak(int count);

  /// No description provided for @sectionToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get sectionToday;

  /// No description provided for @workoutProgressZeroOfOne.
  ///
  /// In en, this message translates to:
  /// **'0 of 1 workout'**
  String get workoutProgressZeroOfOne;

  /// No description provided for @startWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get startWorkout;

  /// No description provided for @sectionQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get sectionQuickActions;

  /// No description provided for @quickActionWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get quickActionWorkout;

  /// No description provided for @quickActionFindGym.
  ///
  /// In en, this message translates to:
  /// **'Find gym'**
  String get quickActionFindGym;

  /// No description provided for @quickActionCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get quickActionCheckIn;

  /// No description provided for @exploreWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Explore workouts'**
  String get exploreWorkouts;

  /// No description provided for @savedWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Saved workouts'**
  String get savedWorkouts;

  /// No description provided for @popularWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Popular workouts'**
  String get popularWorkouts;

  /// No description provided for @filterTargetMuscle.
  ///
  /// In en, this message translates to:
  /// **'Target muscle'**
  String get filterTargetMuscle;

  /// No description provided for @filterAvailableEquipment.
  ///
  /// In en, this message translates to:
  /// **'Available equipment'**
  String get filterAvailableEquipment;

  /// No description provided for @equipmentBodyweight.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get equipmentBodyweight;

  /// No description provided for @equipmentDumbbells.
  ///
  /// In en, this message translates to:
  /// **'Dumbbells'**
  String get equipmentDumbbells;

  /// No description provided for @equipmentBarbell.
  ///
  /// In en, this message translates to:
  /// **'Barbell'**
  String get equipmentBarbell;

  /// No description provided for @equipmentCable.
  ///
  /// In en, this message translates to:
  /// **'Cable'**
  String get equipmentCable;

  /// No description provided for @noWorkoutsMatchFilters.
  ///
  /// In en, this message translates to:
  /// **'No workouts match these filters.'**
  String get noWorkoutsMatchFilters;

  /// No description provided for @namedMuscleWorkout.
  ///
  /// In en, this message translates to:
  /// **'{name} {muscles} workout'**
  String namedMuscleWorkout(String name, String muscles);

  /// No description provided for @workoutDurationExercises.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {exercises}'**
  String workoutDurationExercises(int minutes, String exercises);

  /// No description provided for @sectionYourFriends.
  ///
  /// In en, this message translates to:
  /// **'Your friends'**
  String get sectionYourFriends;

  /// No description provided for @actionSeeCommunity.
  ///
  /// In en, this message translates to:
  /// **'See community'**
  String get actionSeeCommunity;

  /// No description provided for @sectionThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get sectionThisWeek;

  /// No description provided for @weekStatWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get weekStatWorkout;

  /// No description provided for @labelStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get labelStreak;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(int count);

  /// No description provided for @sectionNearYou.
  ///
  /// In en, this message translates to:
  /// **'Near you'**
  String get sectionNearYou;

  /// No description provided for @nearYouGyms.
  ///
  /// In en, this message translates to:
  /// **'Gyms'**
  String get nearYouGyms;

  /// No description provided for @nearYouEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get nearYouEvents;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreTitle;

  /// No description provided for @searchDemoOnlyForNow.
  ///
  /// In en, this message translates to:
  /// **'Search is demo-only for now'**
  String get searchDemoOnlyForNow;

  /// No description provided for @exploreSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search gyms, workouts…'**
  String get exploreSearchHint;

  /// No description provided for @sectionNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get sectionNearby;

  /// No description provided for @categoryGyms.
  ///
  /// In en, this message translates to:
  /// **'Gyms'**
  String get categoryGyms;

  /// No description provided for @categoryTrainers.
  ///
  /// In en, this message translates to:
  /// **'Trainers'**
  String get categoryTrainers;

  /// No description provided for @categoryEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get categoryEvents;

  /// No description provided for @categoryShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get categoryShop;

  /// No description provided for @categoryChallenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get categoryChallenges;

  /// No description provided for @categoryCommunities.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get categoryCommunities;

  /// No description provided for @sectionShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get sectionShop;

  /// No description provided for @shopSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get shopSeeAll;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @orderPlacedDemo.
  ///
  /// In en, this message translates to:
  /// **'Order placed for {product} (demo)'**
  String orderPlacedDemo(String product);

  /// No description provided for @shopHeadlineProtein.
  ///
  /// In en, this message translates to:
  /// **'{name}, we picked the best protein for you'**
  String shopHeadlineProtein(String name);

  /// No description provided for @shopHeadlineDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery to {area}'**
  String shopHeadlineDelivery(String area);

  /// No description provided for @shopHeadlineNoEquipment.
  ///
  /// In en, this message translates to:
  /// **'Train at home — all-in-one kit for you'**
  String get shopHeadlineNoEquipment;

  /// No description provided for @shopPriceEtb.
  ///
  /// In en, this message translates to:
  /// **'{price} ETB'**
  String shopPriceEtb(String price);

  /// No description provided for @shopDiscountPercent.
  ///
  /// In en, this message translates to:
  /// **'-{percent}%'**
  String shopDiscountPercent(int percent);

  /// No description provided for @shopFreeDeliveryTo.
  ///
  /// In en, this message translates to:
  /// **'Free delivery to {area}'**
  String shopFreeDeliveryTo(String area);

  /// No description provided for @shopDeliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to {area}'**
  String shopDeliverTo(String area);

  /// No description provided for @shopForYouBadge.
  ///
  /// In en, this message translates to:
  /// **'For you'**
  String get shopForYouBadge;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @checkoutPayWithTelebirr.
  ///
  /// In en, this message translates to:
  /// **'Telebirr'**
  String get checkoutPayWithTelebirr;

  /// No description provided for @checkoutPayingTelebirr.
  ///
  /// In en, this message translates to:
  /// **'Opening…'**
  String get checkoutPayingTelebirr;

  /// No description provided for @checkoutPayManually.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get checkoutPayManually;

  /// No description provided for @checkoutManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual payment'**
  String get checkoutManualTitle;

  /// No description provided for @checkoutManualIntro.
  ///
  /// In en, this message translates to:
  /// **'Follow these steps, then confirm once you’ve paid.'**
  String get checkoutManualIntro;

  /// No description provided for @checkoutManualStep1.
  ///
  /// In en, this message translates to:
  /// **'Open your Telebirr or bank app'**
  String get checkoutManualStep1;

  /// No description provided for @checkoutManualStep2.
  ///
  /// In en, this message translates to:
  /// **'Send {amount} to PrimeGym Merchant (1000 2345 6789)'**
  String checkoutManualStep2(String amount);

  /// No description provided for @checkoutManualStep3.
  ///
  /// In en, this message translates to:
  /// **'Use your order note: PG-{code}'**
  String checkoutManualStep3(String code);

  /// No description provided for @checkoutManualStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep the SMS receipt until delivery'**
  String get checkoutManualStep4;

  /// No description provided for @checkoutManualConfirm.
  ///
  /// In en, this message translates to:
  /// **'I’ve paid'**
  String get checkoutManualConfirm;

  /// No description provided for @checkoutPoweredByChapa.
  ///
  /// In en, this message translates to:
  /// **'Secure checkout via Chapa (demo)'**
  String get checkoutPoweredByChapa;

  /// No description provided for @checkoutDeliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to {area}'**
  String checkoutDeliverTo(String area);

  /// No description provided for @checkoutProductMissing.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get checkoutProductMissing;

  /// No description provided for @checkoutIncludes.
  ///
  /// In en, this message translates to:
  /// **'What’s included'**
  String get checkoutIncludes;

  /// No description provided for @checkoutFreeDeliveryBadge.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get checkoutFreeDeliveryBadge;

  /// No description provided for @checkoutSecurePay.
  ///
  /// In en, this message translates to:
  /// **'Secure payment'**
  String get checkoutSecurePay;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// No description provided for @ordersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get ordersEmptyTitle;

  /// No description provided for @ordersEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Order something from the shop and track it here.'**
  String get ordersEmptyBody;

  /// No description provided for @browseShop.
  ///
  /// In en, this message translates to:
  /// **'Browse shop'**
  String get browseShop;

  /// No description provided for @orderDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderDetailTitle;

  /// No description provided for @orderChapaRef.
  ///
  /// In en, this message translates to:
  /// **'Chapa ref · {ref}'**
  String orderChapaRef(String ref);

  /// No description provided for @orderContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact · {phone}'**
  String orderContactPhone(String phone);

  /// No description provided for @orderStatusPaymentInitiated.
  ///
  /// In en, this message translates to:
  /// **'Payment initiated'**
  String get orderStatusPaymentInitiated;

  /// No description provided for @orderStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get orderStatusPaid;

  /// No description provided for @orderStatusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get orderStatusPreparing;

  /// No description provided for @orderStatusOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get orderStatusOutForDelivery;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get orderTrackingTitle;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your order is confirmed. You can track delivery anytime.'**
  String get paymentSuccessBody;

  /// No description provided for @sectionPopularExercises.
  ///
  /// In en, this message translates to:
  /// **'Popular exercises'**
  String get sectionPopularExercises;

  /// No description provided for @sectionRecommendedWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Recommended workouts'**
  String get sectionRecommendedWorkouts;

  /// No description provided for @workoutDurationLevel.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {level}'**
  String workoutDurationLevel(int minutes, String level);

  /// No description provided for @sectionTrendingInAddis.
  ///
  /// In en, this message translates to:
  /// **'Trending in Addis'**
  String get sectionTrendingInAddis;

  /// No description provided for @checkedInTodayCount.
  ///
  /// In en, this message translates to:
  /// **'{rating} ★ · {count} checked in today'**
  String checkedInTodayCount(num rating, int count);

  /// No description provided for @trainersTitle.
  ///
  /// In en, this message translates to:
  /// **'Trainers'**
  String get trainersTitle;

  /// No description provided for @searchDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'Search is demo-only'**
  String get searchDemoOnly;

  /// No description provided for @searchTrainersHint.
  ///
  /// In en, this message translates to:
  /// **'Search trainers…'**
  String get searchTrainersHint;

  /// No description provided for @trainerPricePerSession.
  ///
  /// In en, this message translates to:
  /// **'{rating} ★ · {price} / session'**
  String trainerPricePerSession(num rating, String price);

  /// No description provided for @trainerDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get trainerDetailTitle;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @followingDemo.
  ///
  /// In en, this message translates to:
  /// **'Following {name} (demo)'**
  String followingDemo(String name);

  /// No description provided for @statRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get statRating;

  /// No description provided for @statYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get statYears;

  /// No description provided for @statSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get statSession;

  /// No description provided for @sectionPrograms.
  ///
  /// In en, this message translates to:
  /// **'Programs'**
  String get sectionPrograms;

  /// No description provided for @bookDemo.
  ///
  /// In en, this message translates to:
  /// **'Book (demo)'**
  String get bookDemo;

  /// No description provided for @bookingDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'Booking is demo-only'**
  String get bookingDemoOnly;

  /// No description provided for @eventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTitle;

  /// No description provided for @eventAttendingMeta.
  ///
  /// In en, this message translates to:
  /// **'{time} · {count} attending'**
  String eventAttendingMeta(String time, int count);

  /// No description provided for @eventDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get eventDetailTitle;

  /// No description provided for @attendingCount.
  ///
  /// In en, this message translates to:
  /// **'{count} attending'**
  String attendingCount(int count);

  /// No description provided for @sectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// No description provided for @joinEventDemo.
  ///
  /// In en, this message translates to:
  /// **'Join event (demo)'**
  String get joinEventDemo;

  /// No description provided for @joinedEventDemo.
  ///
  /// In en, this message translates to:
  /// **'Joined event (demo)'**
  String get joinedEventDemo;

  /// No description provided for @challengesTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challengesTitle;

  /// No description provided for @noChallengesInFilter.
  ///
  /// In en, this message translates to:
  /// **'No challenges in this filter'**
  String get noChallengesInFilter;

  /// No description provided for @challengeProgressMeta.
  ///
  /// In en, this message translates to:
  /// **'{progress}/{goal} · {days} days left · {participants} people'**
  String challengeProgressMeta(
    int progress,
    int goal,
    int days,
    int participants,
  );

  /// No description provided for @addedToFavoritesDemo.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites (demo)'**
  String get addedToFavoritesDemo;

  /// No description provided for @equipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment: {equipment}'**
  String equipmentLabel(String equipment);

  /// No description provided for @secondaryMusclesLabel.
  ///
  /// In en, this message translates to:
  /// **'Secondary: {muscles}'**
  String secondaryMusclesLabel(String muscles);

  /// No description provided for @instructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructionsTitle;

  /// No description provided for @commonMistakesTitle.
  ///
  /// In en, this message translates to:
  /// **'Common mistakes'**
  String get commonMistakesTitle;

  /// No description provided for @exerciseVideoTitle.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get exerciseVideoTitle;

  /// No description provided for @addToWorkout.
  ///
  /// In en, this message translates to:
  /// **'Add to workout'**
  String get addToWorkout;

  /// No description provided for @addedToWorkoutDemo.
  ///
  /// In en, this message translates to:
  /// **'Added to workout (demo)'**
  String get addedToWorkoutDemo;

  /// No description provided for @gymsNearYou.
  ///
  /// In en, this message translates to:
  /// **'Gyms near you'**
  String get gymsNearYou;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(num distance);

  /// No description provided for @gymOpenUntilRating.
  ///
  /// In en, this message translates to:
  /// **'{rating} ★ · Open until {time}'**
  String gymOpenUntilRating(num rating, String time);

  /// No description provided for @peopleCheckedInToday.
  ///
  /// In en, this message translates to:
  /// **'{count} people checked in today'**
  String peopleCheckedInToday(int count);

  /// No description provided for @gymDistanceAway.
  ///
  /// In en, this message translates to:
  /// **'{rating} ★ · {distance} km away'**
  String gymDistanceAway(num rating, num distance);

  /// No description provided for @sectionInformation.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get sectionInformation;

  /// No description provided for @infoHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get infoHours;

  /// No description provided for @openUntil.
  ///
  /// In en, this message translates to:
  /// **'Open until {time}'**
  String openUntil(String time);

  /// No description provided for @infoMembership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get infoMembership;

  /// No description provided for @infoLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get infoLocation;

  /// No description provided for @infoAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get infoAmenities;

  /// No description provided for @sectionCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get sectionCommunity;

  /// No description provided for @gymCommunitySuffix.
  ///
  /// In en, this message translates to:
  /// **'{name} community'**
  String gymCommunitySuffix(String name);

  /// No description provided for @membersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String membersCount(int count);

  /// No description provided for @activeThisWeek.
  ///
  /// In en, this message translates to:
  /// **'{count} active this week'**
  String activeThisWeek(int count);

  /// No description provided for @septemberChallenge.
  ///
  /// In en, this message translates to:
  /// **'September challenge'**
  String get septemberChallenge;

  /// No description provided for @joinCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join community'**
  String get joinCommunity;

  /// No description provided for @joinedCommunityDemo.
  ///
  /// In en, this message translates to:
  /// **'Joined community (demo)'**
  String get joinedCommunityDemo;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get checkIn;

  /// No description provided for @checkedIn.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get checkedIn;

  /// No description provided for @checkInXpPeople.
  ///
  /// In en, this message translates to:
  /// **'+25 XP · {count} people here'**
  String checkInXpPeople(int count);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @startWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get startWorkoutTitle;

  /// No description provided for @todaysSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Today\'s suggestion'**
  String get todaysSuggestion;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for you'**
  String get recommendedForYou;

  /// No description provided for @exercisesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} exercises'**
  String exercisesCount(int count);

  /// No description provided for @startTodaysPlan.
  ///
  /// In en, this message translates to:
  /// **'Start today\'s plan'**
  String get startTodaysPlan;

  /// No description provided for @orTrainSomethingElse.
  ///
  /// In en, this message translates to:
  /// **'Or train something else'**
  String get orTrainSomethingElse;

  /// No description provided for @noWorkoutsForFilter.
  ///
  /// In en, this message translates to:
  /// **'No workouts for this filter'**
  String get noWorkoutsForFilter;

  /// No description provided for @basedOnYou.
  ///
  /// In en, this message translates to:
  /// **'Based on you'**
  String get basedOnYou;

  /// No description provided for @workoutDurationMuscles.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {muscles}'**
  String workoutDurationMuscles(int minutes, String muscles);

  /// No description provided for @workoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get workoutTitle;

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// No description provided for @exercisesCountCapitalized.
  ///
  /// In en, this message translates to:
  /// **'{count} Exercises'**
  String exercisesCountCapitalized(int count);

  /// No description provided for @setsTimesReps.
  ///
  /// In en, this message translates to:
  /// **'{sets} × {reps}'**
  String setsTimesReps(int sets, String reps);

  /// No description provided for @setsTimesRepsWithWeight.
  ///
  /// In en, this message translates to:
  /// **'{sets} × {reps} · {weight}'**
  String setsTimesRepsWithWeight(int sets, String reps, String weight);

  /// No description provided for @suggestMoreLikeThis.
  ///
  /// In en, this message translates to:
  /// **'Suggest more like this'**
  String get suggestMoreLikeThis;

  /// No description provided for @showThisLess.
  ///
  /// In en, this message translates to:
  /// **'Show this less'**
  String get showThisLess;

  /// No description provided for @exerciseProgress.
  ///
  /// In en, this message translates to:
  /// **'Exercise {current} of {total}'**
  String exerciseProgress(int current, int total);

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @skipExercise.
  ///
  /// In en, this message translates to:
  /// **'Skip exercise'**
  String get skipExercise;

  /// No description provided for @whyDidYouSkip.
  ///
  /// In en, this message translates to:
  /// **'Why did you skip?'**
  String get whyDidYouSkip;

  /// No description provided for @skipFeedback.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipFeedback;

  /// No description provided for @skipReasonTooHard.
  ///
  /// In en, this message translates to:
  /// **'Too hard'**
  String get skipReasonTooHard;

  /// No description provided for @skipReasonNoEquipment.
  ///
  /// In en, this message translates to:
  /// **'No equipment'**
  String get skipReasonNoEquipment;

  /// No description provided for @skipReasonInjured.
  ///
  /// In en, this message translates to:
  /// **'Injured / pain'**
  String get skipReasonInjured;

  /// No description provided for @skipReasonDidntLike.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t like it'**
  String get skipReasonDidntLike;

  /// No description provided for @skipReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get skipReasonOther;

  /// No description provided for @setProgress.
  ///
  /// In en, this message translates to:
  /// **'Set {current} of {total}'**
  String setProgress(int current, int total);

  /// No description provided for @weightTimesReps.
  ///
  /// In en, this message translates to:
  /// **'{weight} × {reps}'**
  String weightTimesReps(String weight, String reps);

  /// No description provided for @previousSet.
  ///
  /// In en, this message translates to:
  /// **'Previous: {weight} × {reps}'**
  String previousSet(String weight, String reps);

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg'**
  String weightKg(num weight);

  /// No description provided for @labelWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get labelWeight;

  /// No description provided for @labelReps.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get labelReps;

  /// No description provided for @nice.
  ///
  /// In en, this message translates to:
  /// **'Nice!'**
  String get nice;

  /// No description provided for @completeSet.
  ///
  /// In en, this message translates to:
  /// **'Complete set'**
  String get completeSet;

  /// No description provided for @workoutComplete.
  ///
  /// In en, this message translates to:
  /// **'Workout complete!'**
  String get workoutComplete;

  /// No description provided for @minutesCount.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String minutesCount(int minutes);

  /// No description provided for @exercisesAndSets.
  ///
  /// In en, this message translates to:
  /// **'{exercises} exercises · {sets} sets'**
  String exercisesAndSets(int exercises, int sets);

  /// No description provided for @xpGain.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP'**
  String xpGain(int xp);

  /// No description provided for @streakMaintained.
  ///
  /// In en, this message translates to:
  /// **'{days}-day streak maintained'**
  String streakMaintained(int days);

  /// No description provided for @personalizationUpdatedDemo.
  ///
  /// In en, this message translates to:
  /// **'Personalization updated (demo)'**
  String get personalizationUpdatedDemo;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @sharedToCommunityDemo.
  ///
  /// In en, this message translates to:
  /// **'Shared to community (demo)'**
  String get sharedToCommunityDemo;

  /// No description provided for @wizardSwipeBackHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe right anytime to go back'**
  String get wizardSwipeBackHint;

  /// No description provided for @wizardSwipeBothHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to continue · right to go back'**
  String get wizardSwipeBothHint;

  /// No description provided for @wizardSwipeBackOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe right to go back'**
  String get wizardSwipeBackOnlyHint;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @savedAsPrivateProgress.
  ///
  /// In en, this message translates to:
  /// **'Saved as private progress'**
  String get savedAsPrivateProgress;

  /// No description provided for @progressPostedToFeed.
  ///
  /// In en, this message translates to:
  /// **'Progress posted to feed'**
  String get progressPostedToFeed;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @postProgress.
  ///
  /// In en, this message translates to:
  /// **'Post progress'**
  String get postProgress;

  /// No description provided for @activeChallenges.
  ///
  /// In en, this message translates to:
  /// **'Active challenges'**
  String get activeChallenges;

  /// No description provided for @challengeDaysLeftShort.
  ///
  /// In en, this message translates to:
  /// **'{progress}/{goal} · {days}d left'**
  String challengeDaysLeftShort(int progress, int goal, int days);

  /// No description provided for @sectionFeed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get sectionFeed;

  /// No description provided for @privateBadge.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get privateBadge;

  /// No description provided for @cheer.
  ///
  /// In en, this message translates to:
  /// **'Cheer'**
  String get cheer;

  /// No description provided for @weightKgLabel.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg'**
  String weightKgLabel(num weight);

  /// No description provided for @challengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get challengeTitle;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days} days left'**
  String daysLeft(int days);

  /// No description provided for @participantsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} participants'**
  String participantsCount(int count);

  /// No description provided for @viewLeaderboardDemo.
  ///
  /// In en, this message translates to:
  /// **'View leaderboard (demo)'**
  String get viewLeaderboardDemo;

  /// No description provided for @leaderboardDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard is demo-only'**
  String get leaderboardDemoOnly;

  /// No description provided for @emotionFiredUp.
  ///
  /// In en, this message translates to:
  /// **'Fired up'**
  String get emotionFiredUp;

  /// No description provided for @emotionStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get emotionStrong;

  /// No description provided for @emotionHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get emotionHappy;

  /// No description provided for @emotionCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get emotionCalm;

  /// No description provided for @emotionDetermined.
  ///
  /// In en, this message translates to:
  /// **'Determined'**
  String get emotionDetermined;

  /// No description provided for @emotionProud.
  ///
  /// In en, this message translates to:
  /// **'Proud'**
  String get emotionProud;

  /// No description provided for @pickHowYouFeel.
  ///
  /// In en, this message translates to:
  /// **'Pick how you feel'**
  String get pickHowYouFeel;

  /// No description provided for @enterValidWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight in kg'**
  String get enterValidWeightKg;

  /// No description provided for @feelingEmotionToday.
  ///
  /// In en, this message translates to:
  /// **'Feeling {emotion} today'**
  String feelingEmotionToday(String emotion);

  /// No description provided for @feedTypeProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get feedTypeProgress;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @postProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Post progress'**
  String get postProgressTitle;

  /// No description provided for @photoSection.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photoSection;

  /// No description provided for @tapToChangePhotoDemo.
  ///
  /// In en, this message translates to:
  /// **'Tap to change photo (demo)'**
  String get tapToChangePhotoDemo;

  /// No description provided for @howDoYouFeel.
  ///
  /// In en, this message translates to:
  /// **'How do you feel?'**
  String get howDoYouFeel;

  /// No description provided for @weightOptional.
  ///
  /// In en, this message translates to:
  /// **'Weight (optional)'**
  String get weightOptional;

  /// No description provided for @weightHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 72.5'**
  String get weightHint;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @captionOptional.
  ///
  /// In en, this message translates to:
  /// **'Caption (optional)'**
  String get captionOptional;

  /// No description provided for @captionHint.
  ///
  /// In en, this message translates to:
  /// **'Share a note about your session…'**
  String get captionHint;

  /// No description provided for @makePrivate.
  ///
  /// In en, this message translates to:
  /// **'Make private'**
  String get makePrivate;

  /// No description provided for @privateOnlyYou.
  ///
  /// In en, this message translates to:
  /// **'Only you can see this'**
  String get privateOnlyYou;

  /// No description provided for @visibleOnFeed.
  ///
  /// In en, this message translates to:
  /// **'Visible on your community feed'**
  String get visibleOnFeed;

  /// No description provided for @postPrivately.
  ///
  /// In en, this message translates to:
  /// **'Post privately'**
  String get postPrivately;

  /// No description provided for @visibilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Who can see this'**
  String get visibilityLabel;

  /// No description provided for @visibilityPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get visibilityPrivate;

  /// No description provided for @visibilityFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get visibilityFriends;

  /// No description provided for @visibilityPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get visibilityPublic;

  /// No description provided for @visibilityPrivateHint.
  ///
  /// In en, this message translates to:
  /// **'Only you can see this'**
  String get visibilityPrivateHint;

  /// No description provided for @visibilityFriendsHint.
  ///
  /// In en, this message translates to:
  /// **'Visible to your friends'**
  String get visibilityFriendsHint;

  /// No description provided for @visibilityPublicHint.
  ///
  /// In en, this message translates to:
  /// **'Visible on the community feed'**
  String get visibilityPublicHint;

  /// No description provided for @friendsOnlyBadge.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friendsOnlyBadge;

  /// No description provided for @publicBadge.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get publicBadge;

  /// No description provided for @savedAsFriendsProgress.
  ///
  /// In en, this message translates to:
  /// **'Shared with friends'**
  String get savedAsFriendsProgress;

  /// No description provided for @sectionFriendsProgress.
  ///
  /// In en, this message translates to:
  /// **'Friends\' progress'**
  String get sectionFriendsProgress;

  /// No description provided for @mediaTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get mediaTypeLabel;

  /// No description provided for @mediaPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get mediaPhoto;

  /// No description provided for @mediaVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get mediaVideo;

  /// No description provided for @videoSection.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get videoSection;

  /// No description provided for @tapToChangeVideoDemo.
  ///
  /// In en, this message translates to:
  /// **'Tap to change video (demo)'**
  String get tapToChangeVideoDemo;

  /// No description provided for @upvote.
  ///
  /// In en, this message translates to:
  /// **'Upvote'**
  String get upvote;

  /// No description provided for @howToDoThis.
  ///
  /// In en, this message translates to:
  /// **'How to'**
  String get howToDoThis;

  /// No description provided for @formTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Form tips'**
  String get formTipsTitle;

  /// No description provided for @progressDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressDetailTitle;

  /// No description provided for @progressNotFound.
  ///
  /// In en, this message translates to:
  /// **'This progress post isn\'t available'**
  String get progressNotFound;

  /// No description provided for @friendProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get friendProfile;

  /// No description provided for @friendTabProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get friendTabProgress;

  /// No description provided for @friendTabWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get friendTabWorkouts;

  /// No description provided for @friendProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get friendProgress;

  /// No description provided for @friendExercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get friendExercises;

  /// No description provided for @friendWorkoutTimeline.
  ///
  /// In en, this message translates to:
  /// **'Workout timeline'**
  String get friendWorkoutTimeline;

  /// No description provided for @friendWorkoutSection.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get friendWorkoutSection;

  /// No description provided for @friendStatPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get friendStatPosts;

  /// No description provided for @friendStatWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get friendStatWorkouts;

  /// No description provided for @friendStatStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get friendStatStreak;

  /// No description provided for @friendInbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get friendInbox;

  /// No description provided for @friendInboxComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Messaging with friends is coming soon'**
  String get friendInboxComingSoon;

  /// No description provided for @friendFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get friendFollow;

  /// No description provided for @friendFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get friendFollowing;

  /// No description provided for @friendMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get friendMessage;

  /// No description provided for @friendShareProfile.
  ///
  /// In en, this message translates to:
  /// **'Share profile'**
  String get friendShareProfile;

  /// No description provided for @friendCopyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get friendCopyLink;

  /// No description provided for @friendLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get friendLinkCopied;

  /// No description provided for @friendStatFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get friendStatFollowing;

  /// No description provided for @friendStatFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get friendStatFollowers;

  /// No description provided for @friendStatUpvotes.
  ///
  /// In en, this message translates to:
  /// **'Upvotes'**
  String get friendStatUpvotes;

  /// No description provided for @friendWorkoutExercises.
  ///
  /// In en, this message translates to:
  /// **'{count} exercises'**
  String friendWorkoutExercises(int count);

  /// No description provided for @friendWorkoutSets.
  ///
  /// In en, this message translates to:
  /// **'{count} sets'**
  String friendWorkoutSets(int count);

  /// No description provided for @friendWorkoutVolume.
  ///
  /// In en, this message translates to:
  /// **'{kg} kg volume'**
  String friendWorkoutVolume(String kg);

  /// No description provided for @friendWorkoutVolumeShort.
  ///
  /// In en, this message translates to:
  /// **'{kg} kg'**
  String friendWorkoutVolumeShort(String kg);

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @saveForLater.
  ///
  /// In en, this message translates to:
  /// **'Save for later'**
  String get saveForLater;

  /// No description provided for @savedForLater.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedForLater;

  /// No description provided for @savedForLaterSnack.
  ///
  /// In en, this message translates to:
  /// **'Workout saved for later'**
  String get savedForLaterSnack;

  /// No description provided for @removeFromSaved.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get removeFromSaved;

  /// No description provided for @removedFromSavedSnack.
  ///
  /// In en, this message translates to:
  /// **'Removed from saved'**
  String get removedFromSavedSnack;

  /// No description provided for @saveWorkout.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveWorkout;

  /// No description provided for @unsaveWorkout.
  ///
  /// In en, this message translates to:
  /// **'Unsave'**
  String get unsaveWorkout;

  /// No description provided for @noFriendWorkoutsYet.
  ///
  /// In en, this message translates to:
  /// **'No workouts logged yet'**
  String get noFriendWorkoutsYet;

  /// No description provided for @workoutSetsRepsWeight.
  ///
  /// In en, this message translates to:
  /// **'{sets}×{reps} @ {weight} kg'**
  String workoutSetsRepsWeight(int sets, int reps, String weight);

  /// No description provided for @friendNotFound.
  ///
  /// In en, this message translates to:
  /// **'Friend not found'**
  String get friendNotFound;

  /// No description provided for @noFriendProgressYet.
  ///
  /// In en, this message translates to:
  /// **'No visible progress yet'**
  String get noFriendProgressYet;

  /// No description provided for @viewLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'View leaderboard'**
  String get viewLeaderboard;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @youLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get youLabel;

  /// No description provided for @sectionComingLater.
  ///
  /// In en, this message translates to:
  /// **'Coming later'**
  String get sectionComingLater;

  /// No description provided for @comingLaterHint.
  ///
  /// In en, this message translates to:
  /// **'Trainers, gyms, and events — soon'**
  String get comingLaterHint;

  /// No description provided for @sectionTrain.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get sectionTrain;

  /// No description provided for @rankUpSnack.
  ///
  /// In en, this message translates to:
  /// **'You\'re #{rank} on the board!'**
  String rankUpSnack(int rank);

  /// No description provided for @activityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activityTitle;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(int level);

  /// No description provided for @dayStreakShort.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String dayStreakShort(int count);

  /// No description provided for @xpProgress.
  ///
  /// In en, this message translates to:
  /// **'{xp} / {xpToNext} XP'**
  String xpProgress(int xp, int xpToNext);

  /// No description provided for @statWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get statWorkouts;

  /// No description provided for @statMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get statMinutes;

  /// No description provided for @statXp.
  ///
  /// In en, this message translates to:
  /// **'XP'**
  String get statXp;

  /// No description provided for @sectionRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get sectionRecent;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileLevelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Level {level} · Intermediate'**
  String profileLevelIntermediate(int level);

  /// No description provided for @locationStreakDays.
  ///
  /// In en, this message translates to:
  /// **'Addis Ababa · {days}-day streak'**
  String locationStreakDays(int days);

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goalsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsNotificationsOn;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage who sees your progress'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settingsSubscription;

  /// No description provided for @settingsFreePlan.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get settingsFreePlan;

  /// No description provided for @replayOnboardingDemo.
  ///
  /// In en, this message translates to:
  /// **'Replay onboarding (demo)'**
  String get replayOnboardingDemo;

  /// No description provided for @settingsDemoOnly.
  ///
  /// In en, this message translates to:
  /// **'{title} is demo-only'**
  String settingsDemoOnly(String title);

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @onboardingPlanTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalized training'**
  String get onboardingPlanTrainingTitle;

  /// No description provided for @onboardingPlanTrainingBody.
  ///
  /// In en, this message translates to:
  /// **'Sessions built for {environment} — the right moves for your gear and space.'**
  String onboardingPlanTrainingBody(String environment);

  /// No description provided for @onboardingPlanCommunityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community that keeps you going'**
  String get onboardingPlanCommunityTitle;

  /// No description provided for @onboardingPlanCommunityBody.
  ///
  /// In en, this message translates to:
  /// **'Follow friends, share progress, and stay accountable with lifters across Addis.'**
  String get onboardingPlanCommunityBody;

  /// No description provided for @onboardingPlanTrainerTitle.
  ///
  /// In en, this message translates to:
  /// **'Online personal trainers'**
  String get onboardingPlanTrainerTitle;

  /// No description provided for @onboardingPlanTrainerBody.
  ///
  /// In en, this message translates to:
  /// **'Get coached remotely by vetted trainers who match your goals and schedule.'**
  String get onboardingPlanTrainerBody;

  /// No description provided for @onboardingPlanReadyBadge.
  ///
  /// In en, this message translates to:
  /// **'Personalized for you'**
  String get onboardingPlanReadyBadge;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en', 'om'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
