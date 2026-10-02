import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MuscleFilterCard extends StatelessWidget {
  const MuscleFilterCard({
    super.key,
    required this.label,
    required this.imageAsset,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final String? imageAsset;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const cardRadius = BorderRadius.all(Radius.circular(16));
    const imageRadius = BorderRadius.all(Radius.circular(12));

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.accentSoft : Colors.transparent,
        borderRadius: cardRadius,
        border: Border.all(
          color: selected ? AppColors.accent : Colors.transparent,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: imageRadius,
                border: Border.all(
                  color: selected ? Colors.transparent : AppColors.border,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: imageRadius,
                child: imageAsset == null
                    ? Center(
                        child: Icon(
                          Icons.grid_view_rounded,
                          size: 28,
                          color: selected
                              ? AppColors.accent
                              : AppColors.textMuted,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.asset(
                          imageAsset!,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: selected ? AppColors.accent : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      width: 88,
      child: Material(
        color: Colors.transparent,
        child: onTap == null
            ? card
            : InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: card,
              ),
      ),
    );
  }
}
