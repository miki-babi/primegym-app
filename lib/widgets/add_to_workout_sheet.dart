import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/active_workout_controller.dart';
import '../data/app_store.dart';
import '../l10n/l10n_ext.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import 'pg_button.dart';

Future<void> showAddToWorkoutSheet(
  BuildContext context, {
  required String exerciseId,
  required String exerciseName,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return AddToWorkoutSheet(
        exerciseId: exerciseId,
        exerciseName: exerciseName,
      );
    },
  );
}

class AddToWorkoutSheet extends StatefulWidget {
  const AddToWorkoutSheet({
    super.key,
    required this.exerciseId,
    required this.exerciseName,
  });

  final String exerciseId;
  final String exerciseName;

  @override
  State<AddToWorkoutSheet> createState() => _AddToWorkoutSheetState();
}

class _AddToWorkoutSheetState extends State<AddToWorkoutSheet> {
  final TextEditingController _nameController = TextEditingController();
  bool _creating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _confirm(BuildContext context, String destinationName) {
    HapticFeedback.selectionClick();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.addedToNamedWorkout(destinationName)),
      ),
    );
  }

  void _addToActive(BuildContext context) {
    final session = ActiveWorkoutController.instance;
    final id = session.workoutId;
    if (id == null) return;
    session.queueExercise(widget.exerciseId);
    final plan = AppStore.instance.workoutPlanById(id);
    final locale = Localizations.localeOf(context);
    final name = plan?.title.resolve(locale) ?? context.l10n.addToActiveWorkout;
    _confirm(context, name);
  }

  void _addToSaved(BuildContext context, WorkoutPlan plan) {
    AppStore.instance.recordExerciseAddedToPlan(plan.id, widget.exerciseId);
    final locale = Localizations.localeOf(context);
    _confirm(context, plan.title.resolve(locale));
  }

  void _createCollection(BuildContext context) {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    AppStore.instance.createCollection(name, exerciseId: widget.exerciseId);
    _confirm(context, name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final session = ActiveWorkoutController.instance;
    final saved = AppStore.instance.savedWorkoutPlans();
    final hasActive = session.isActive;
    final activePlan =
        hasActive ? AppStore.instance.workoutPlanById(session.workoutId!) : null;
    final empty = !hasActive && saved.isEmpty;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.72;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.addToWorkoutTitle, style: textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                widget.exerciseName,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              if (_creating)
                _buildCreateForm(context)
              else
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      if (hasActive && activePlan != null) ...[
                        _DestinationTile(
                          icon: Icons.play_circle_fill_rounded,
                          title: l10n.addToActiveWorkout,
                          subtitle: l10n.addToActiveWorkoutSubtitle(
                            activePlan.title.resolve(locale),
                          ),
                          emphasized: true,
                          onTap: () => _addToActive(context),
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (empty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            l10n.addToWorkoutEmpty,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                      _DestinationTile(
                        icon: Icons.add_rounded,
                        title: l10n.newCollection,
                        subtitle: l10n.newCollectionSubtitle,
                        onTap: () => setState(() => _creating = true),
                      ),
                      if (saved.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          l10n.addToSavedWorkouts,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        for (var i = 0; i < saved.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          _DestinationTile(
                            icon: isCollectionPlan(saved[i])
                                ? Icons.folder_rounded
                                : Icons.bookmark_rounded,
                            title: saved[i].title.resolve(locale),
                            subtitle:
                                l10n.exercisesCount(saved[i].exercises.length),
                            onTap: () => _addToSaved(context, saved[i]),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool isCollectionPlan(WorkoutPlan plan) =>
      AppStore.instance.isCustomPlan(plan.id);

  Widget _buildCreateForm(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final canCreate = _nameController.text.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _nameController,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _createCollection(context),
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: l10n.collectionNameHint,
            hintStyle: textTheme.titleMedium?.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        PgButton(
          label: l10n.create,
          onPressed: canCreate ? () => _createCollection(context) : null,
        ),
        const SizedBox(height: 8),
        PgButton(
          label: l10n.cancel,
          variant: PgButtonVariant.ghost,
          onPressed: () => setState(() => _creating = false),
        ),
      ],
    );
  }
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: emphasized ? AppColors.accentSoft : AppColors.surfaceElevated,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: emphasized
                        ? AppColors.accentMuted
                        : Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: emphasized ? AppColors.accent : AppColors.textPrimary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall?.copyWith(
                          color: emphasized
                              ? AppColors.accent
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
