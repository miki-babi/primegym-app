import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../l10n/l10n_ext.dart';
import '../models/models.dart';
import '../theme/app_colors.dart';
import 'personalized_shop_card.dart';
import 'pg_button.dart';
import 'pg_card.dart';

/// Image-first product card used by home carousel and Shop featured hero.
class ShopProductHeroCard extends StatelessWidget {
  const ShopProductHeroCard({
    super.key,
    required this.product,
    this.width = 236,
    this.height = 320,
    this.featured = false,
  });

  final ShopProduct product;
  final double? width;
  final double height;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final title = product.title.resolve(locale);
    final price = l10n.shopPriceEtb(formatShopPrice(product.priceEtb));
    final compareAt = product.compareAtPriceEtb;
    final deliveryLine = product.freeDelivery
        ? l10n.shopFreeDeliveryTo(MockData.deliveryArea)
        : l10n.shopDeliverTo(MockData.deliveryArea);
    const radius = BorderRadius.all(Radius.circular(20));

    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        // Keep soft glow visible without clipping neighbors.
        padding: const EdgeInsets.only(bottom: 2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color:
                    AppColors.accent.withValues(alpha: featured ? 0.2 : 0.1),
                blurRadius: featured ? 16 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  product.imageAsset,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.2),
                  errorBuilder: (_, _, _) => ColoredBox(
                    color: AppColors.accentSoft,
                    child: Icon(
                      shopProductIcon(product.kind),
                      color: AppColors.accent,
                      size: 40,
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x40000000),
                        Color(0x59000000),
                        Color(0xF2000000),
                      ],
                      stops: [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (product.hasDiscount)
                            _ShopPill(
                              label: l10n.shopDiscountPercent(
                                product.discountPercent,
                              ),
                              background: AppColors.accent,
                              foreground: const Color(0xFF1A1200),
                            ),
                          if (product.hasDiscount) const SizedBox(width: 6),
                          if (featured)
                            _ShopPill(
                              label: l10n.shopForYouBadge,
                              background:
                                  Colors.white.withValues(alpha: 0.18),
                              foreground: Colors.white,
                            ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        shopProductHeadline(l10n, product),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelLarge?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall?.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (compareAt != null && product.hasDiscount) ...[
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                l10n.shopPriceEtb(formatShopPrice(compareAt)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.55),
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor:
                                      Colors.white.withValues(alpha: 0.45),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              deliveryLine,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      PgButton(
                        label: l10n.order,
                        height: 44,
                        onPressed: () => openShopCheckout(context, product),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Image-thumb list row for Shop browse list.
class ShopProductImageRow extends StatelessWidget {
  const ShopProductImageRow({super.key, required this.product});

  final ShopProduct product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final title = product.title.resolve(locale);
    final blurb = product.blurb.resolve(locale);
    final price = l10n.shopPriceEtb(formatShopPrice(product.priceEtb));
    final compareAt = product.compareAtPriceEtb;
    final deliveryLine = product.freeDelivery
        ? l10n.shopFreeDeliveryTo(MockData.deliveryArea)
        : l10n.shopDeliverTo(MockData.deliveryArea);

    return PgCard(
      onTap: () => openShopCheckout(context, product),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: Image.asset(
                    product.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => ColoredBox(
                      color: AppColors.accentSoft,
                      child: Icon(
                        shopProductIcon(product.kind),
                        color: AppColors.accent,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              if (product.hasDiscount)
                Positioned(
                  top: 4,
                  left: 4,
                  child: _ShopPill(
                    label: l10n.shopDiscountPercent(product.discountPercent),
                    background: AppColors.accent,
                    foreground: const Color(0xFF1A1200),
                    compact: true,
                  ),
                ),
            ],
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
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  blurb,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (compareAt != null && product.hasDiscount) ...[
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          l10n.shopPriceEtb(formatShopPrice(compareAt)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  deliveryLine,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PgButton(
            label: l10n.order,
            expand: false,
            height: 44,
            onPressed: () => openShopCheckout(context, product),
          ),
        ],
      ),
    );
  }
}

class _ShopPill extends StatelessWidget {
  const _ShopPill({
    required this.label,
    required this.background,
    required this.foreground,
    this.compact = false,
  });

  final String label;
  final Color background;
  final Color foreground;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              fontSize: compact ? 9 : null,
            ),
      ),
    );
  }
}
