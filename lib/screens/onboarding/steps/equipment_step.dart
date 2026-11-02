import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/gym_equipment_catalog.dart';
import '../../../data/user_preferences.dart';
import '../../../l10n/l10n_ext.dart';
import '../../../theme/app_colors.dart';

class EquipmentStep extends StatefulWidget {
  const EquipmentStep({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  final Set<AvailableEquipment> selected;
  final ValueChanged<AvailableEquipment> onToggle;

  @override
  State<EquipmentStep> createState() => _EquipmentStepState();
}

class _EquipmentStepState extends State<EquipmentStep> {
  final Set<EquipmentCategory> _expanded = {EquipmentCategory.freeWeights};

  void _toggleCategory(EquipmentCategory category) {
    HapticFeedback.selectionClick();
    setState(() {
      if (!_expanded.add(category)) {
        _expanded.remove(category);
      }
    });
  }

  int _selectedInCategory(EquipmentCategory category) {
    final ids = GymEquipmentCatalog.forCategory(category).map((e) => e.id);
    return ids.where(widget.selected.contains).length;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingEquipmentSelectTitle,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.onboardingEquipmentSelectSubtitle,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.72),
            height: 1.3,
          ),
        ),
        if (widget.selected.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            l10n.onboardingEquipmentSelectedCount(widget.selected.length),
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              for (final category in EquipmentCategory.values) ...[
                _AccordionSection(
                  label: category.label(l10n),
                  selectedCount: _selectedInCategory(category),
                  totalCount: GymEquipmentCatalog.forCategory(category).length,
                  expanded: _expanded.contains(category),
                  onHeaderTap: () => _toggleCategory(category),
                  entries: GymEquipmentCatalog.forCategory(category),
                  selected: widget.selected,
                  onToggle: widget.onToggle,
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AccordionSection extends StatelessWidget {
  const _AccordionSection({
    required this.label,
    required this.selectedCount,
    required this.totalCount,
    required this.expanded,
    required this.onHeaderTap,
    required this.entries,
    required this.selected,
    required this.onToggle,
  });

  final String label;
  final int selectedCount;
  final int totalCount;
  final bool expanded;
  final VoidCallback onHeaderTap;
  final List<GymEquipmentEntry> entries;
  final Set<AvailableEquipment> selected;
  final ValueChanged<AvailableEquipment> onToggle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onHeaderTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Text(
                    '$selectedCount/$totalCount',
                    style: textTheme.labelMedium?.copyWith(
                      color: selectedCount > 0
                          ? AppColors.accent
                          : Colors.white.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                    child: Column(
                      children: [
                        for (var i = 0; i < entries.length; i++) ...[
                          if (i > 0) const SizedBox(height: 8),
                          _EquipmentTile(
                            entry: entries[i],
                            selected: selected.contains(entries[i].id),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              onToggle(entries[i].id);
                            },
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _EquipmentTile extends StatelessWidget {
  const _EquipmentTile({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  static const double height = 72;

  final GymEquipmentEntry entry;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final titleColor = selected ? AppColors.accent : Colors.white;
    final iconColor = selected ? AppColors.accent : Colors.white;

    final fill = selected
        ? AppColors.accent.withValues(alpha: 0.22)
        : Colors.white.withValues(alpha: 0.08);

    return Material(
      color: fill,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.accent
                  : Colors.white.withValues(alpha: 0.14),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.accentMuted
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(entry.icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.id.label(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        color: titleColor,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.id.use(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.68),
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.accent : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppColors.accent
                        : Colors.white.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: AppColors.onAccent,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
