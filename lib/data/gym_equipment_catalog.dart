import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'user_preferences.dart';

enum EquipmentCategory {
  freeWeights,
  structures,
  functional,
  cardio,
  coreRecovery,
}

class GymEquipmentEntry {
  const GymEquipmentEntry({
    required this.id,
    required this.category,
    required this.icon,
  });

  final AvailableEquipment id;
  final EquipmentCategory category;
  final IconData icon;
}

/// Full gym equipment guide used by onboarding equipment selection.
abstract final class GymEquipmentCatalog {
  static const List<GymEquipmentEntry> all = [
    // Free weights & resistance
    GymEquipmentEntry(
      id: AvailableEquipment.bodyweight,
      category: EquipmentCategory.freeWeights,
      icon: Icons.self_improvement_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.dumbbells,
      category: EquipmentCategory.freeWeights,
      icon: Icons.fitness_center_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.barbell,
      category: EquipmentCategory.freeWeights,
      icon: Icons.sports_gymnastics_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.kettlebells,
      category: EquipmentCategory.freeWeights,
      icon: Icons.sports_kabaddi_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.bands,
      category: EquipmentCategory.freeWeights,
      icon: Icons.linear_scale_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.ezCurlBar,
      category: EquipmentCategory.freeWeights,
      icon: Icons.sports_handball_rounded,
    ),
    // Gym structures & benches
    GymEquipmentEntry(
      id: AvailableEquipment.weightBench,
      category: EquipmentCategory.structures,
      icon: Icons.airline_seat_flat_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.squatRack,
      category: EquipmentCategory.structures,
      icon: Icons.view_column_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.pullUpBar,
      category: EquipmentCategory.structures,
      icon: Icons.height_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.machines,
      category: EquipmentCategory.structures,
      icon: Icons.settings_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.cable,
      category: EquipmentCategory.structures,
      icon: Icons.cable_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.smithMachine,
      category: EquipmentCategory.structures,
      icon: Icons.view_agenda_rounded,
    ),
    // Functional & bodyweight tools
    GymEquipmentEntry(
      id: AvailableEquipment.trx,
      category: EquipmentCategory.functional,
      icon: Icons.gesture_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.gymnasticRings,
      category: EquipmentCategory.functional,
      icon: Icons.radio_button_unchecked_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.weightVest,
      category: EquipmentCategory.functional,
      icon: Icons.checkroom_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.plyoBox,
      category: EquipmentCategory.functional,
      icon: Icons.square_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.medicineBall,
      category: EquipmentCategory.functional,
      icon: Icons.sports_baseball_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.sandbag,
      category: EquipmentCategory.functional,
      icon: Icons.shopping_bag_rounded,
    ),
    // Cardio
    GymEquipmentEntry(
      id: AvailableEquipment.treadmill,
      category: EquipmentCategory.cardio,
      icon: Icons.directions_run_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.bike,
      category: EquipmentCategory.cardio,
      icon: Icons.directions_bike_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.rowingMachine,
      category: EquipmentCategory.cardio,
      icon: Icons.rowing_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.skiErg,
      category: EquipmentCategory.cardio,
      icon: Icons.downhill_skiing_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.stairmaster,
      category: EquipmentCategory.cardio,
      icon: Icons.stairs_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.jumpRope,
      category: EquipmentCategory.cardio,
      icon: Icons.timeline_rounded,
    ),
    // Core & recovery
    GymEquipmentEntry(
      id: AvailableEquipment.abWheel,
      category: EquipmentCategory.coreRecovery,
      icon: Icons.rotate_right_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.foamRoller,
      category: EquipmentCategory.coreRecovery,
      icon: Icons.horizontal_rule_rounded,
    ),
    GymEquipmentEntry(
      id: AvailableEquipment.yogaMat,
      category: EquipmentCategory.coreRecovery,
      icon: Icons.crop_landscape_rounded,
    ),
  ];

  static List<GymEquipmentEntry> forCategory(EquipmentCategory category) =>
      all.where((e) => e.category == category).toList(growable: false);
}

extension EquipmentCategoryL10n on EquipmentCategory {
  String label(AppLocalizations l10n) => switch (this) {
    EquipmentCategory.freeWeights => l10n.equipmentCategoryFreeWeights,
    EquipmentCategory.structures => l10n.equipmentCategoryStructures,
    EquipmentCategory.functional => l10n.equipmentCategoryFunctional,
    EquipmentCategory.cardio => l10n.equipmentCategoryCardio,
    EquipmentCategory.coreRecovery => l10n.equipmentCategoryCoreRecovery,
  };
}

extension AvailableEquipmentL10n on AvailableEquipment {
  String label(AppLocalizations l10n) => switch (this) {
    AvailableEquipment.bodyweight => l10n.equipmentBodyweight,
    AvailableEquipment.dumbbells => l10n.equipmentDumbbells,
    AvailableEquipment.barbell => l10n.equipmentBarbell,
    AvailableEquipment.kettlebells => l10n.equipmentKettlebells,
    AvailableEquipment.bands => l10n.equipmentResistanceBands,
    AvailableEquipment.ezCurlBar => l10n.equipmentEzCurlBar,
    AvailableEquipment.weightBench => l10n.equipmentWeightBench,
    AvailableEquipment.squatRack => l10n.equipmentSquatRack,
    AvailableEquipment.pullUpBar => l10n.equipmentPullUpBar,
    AvailableEquipment.machines => l10n.equipmentMachines,
    AvailableEquipment.cable => l10n.equipmentCableMachine,
    AvailableEquipment.smithMachine => l10n.equipmentSmithMachine,
    AvailableEquipment.trx => l10n.equipmentTrx,
    AvailableEquipment.gymnasticRings => l10n.equipmentGymnasticRings,
    AvailableEquipment.weightVest => l10n.equipmentWeightVest,
    AvailableEquipment.plyoBox => l10n.equipmentPlyoBox,
    AvailableEquipment.medicineBall => l10n.equipmentMedicineBall,
    AvailableEquipment.sandbag => l10n.equipmentSandbag,
    AvailableEquipment.treadmill => l10n.equipmentTreadmill,
    AvailableEquipment.bike => l10n.equipmentBike,
    AvailableEquipment.rowingMachine => l10n.equipmentRowingMachine,
    AvailableEquipment.skiErg => l10n.equipmentSkiErg,
    AvailableEquipment.stairmaster => l10n.equipmentStairmaster,
    AvailableEquipment.jumpRope => l10n.equipmentJumpRope,
    AvailableEquipment.abWheel => l10n.equipmentAbWheel,
    AvailableEquipment.foamRoller => l10n.equipmentFoamRoller,
    AvailableEquipment.yogaMat => l10n.equipmentYogaMat,
  };

  String use(AppLocalizations l10n) => switch (this) {
    AvailableEquipment.bodyweight => l10n.equipmentUseBodyweight,
    AvailableEquipment.dumbbells => l10n.equipmentUseDumbbells,
    AvailableEquipment.barbell => l10n.equipmentUseBarbell,
    AvailableEquipment.kettlebells => l10n.equipmentUseKettlebells,
    AvailableEquipment.bands => l10n.equipmentUseResistanceBands,
    AvailableEquipment.ezCurlBar => l10n.equipmentUseEzCurlBar,
    AvailableEquipment.weightBench => l10n.equipmentUseWeightBench,
    AvailableEquipment.squatRack => l10n.equipmentUseSquatRack,
    AvailableEquipment.pullUpBar => l10n.equipmentUsePullUpBar,
    AvailableEquipment.machines => l10n.equipmentUseMachines,
    AvailableEquipment.cable => l10n.equipmentUseCableMachine,
    AvailableEquipment.smithMachine => l10n.equipmentUseSmithMachine,
    AvailableEquipment.trx => l10n.equipmentUseTrx,
    AvailableEquipment.gymnasticRings => l10n.equipmentUseGymnasticRings,
    AvailableEquipment.weightVest => l10n.equipmentUseWeightVest,
    AvailableEquipment.plyoBox => l10n.equipmentUsePlyoBox,
    AvailableEquipment.medicineBall => l10n.equipmentUseMedicineBall,
    AvailableEquipment.sandbag => l10n.equipmentUseSandbag,
    AvailableEquipment.treadmill => l10n.equipmentUseTreadmill,
    AvailableEquipment.bike => l10n.equipmentUseBike,
    AvailableEquipment.rowingMachine => l10n.equipmentUseRowingMachine,
    AvailableEquipment.skiErg => l10n.equipmentUseSkiErg,
    AvailableEquipment.stairmaster => l10n.equipmentUseStairmaster,
    AvailableEquipment.jumpRope => l10n.equipmentUseJumpRope,
    AvailableEquipment.abWheel => l10n.equipmentUseAbWheel,
    AvailableEquipment.foamRoller => l10n.equipmentUseFoamRoller,
    AvailableEquipment.yogaMat => l10n.equipmentUseYogaMat,
  };
}
