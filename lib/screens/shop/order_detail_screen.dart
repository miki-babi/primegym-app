import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/order_store.dart';
import '../../l10n/l10n_ext.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/personalized_shop_card.dart';
import '../../widgets/pg_card.dart';
import 'orders_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final order = OrderStore.instance.orderById(orderId);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/orders');
              }
            },
          ),
          title: Text(l10n.orderDetailTitle),
        ),
        body: Center(child: Text(l10n.ordersEmptyTitle)),
      );
    }

    final price = l10n.shopPriceEtb(formatShopPrice(order.priceEtb));
    final steps = ShopOrderStatus.values;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/orders');
            }
          },
        ),
        title: Text(l10n.orderDetailTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          PgCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: Image.asset(
                      order.productImageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const ColoredBox(
                        color: AppColors.accentSoft,
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.productTitle, style: textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text(
                        price,
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PgCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.checkoutDeliverTo(order.deliveryArea),
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                if (order.phone.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_rounded,
                        size: 18,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.orderContactPhone(order.phone),
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
                if (order.chapaRef != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.receipt_long_rounded,
                        size: 18,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.orderChapaRef(order.chapaRef!),
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(l10n.orderTrackingTitle, style: textTheme.titleMedium),
          const SizedBox(height: 16),
          PgCard(
            child: Column(
              children: [
                for (var i = 0; i < steps.length; i++) ...[
                  _TimelineStep(
                    label: orderStatusLabel(l10n, steps[i]),
                    completed: order.status.stepIndex >= steps[i].stepIndex,
                    isCurrent: order.status == steps[i],
                    isLast: i == steps.length - 1,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.completed,
    required this.isCurrent,
    required this.isLast,
  });

  final String label;
  final bool completed;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = completed ? AppColors.accent : AppColors.textMuted;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: completed ? AppColors.accentSoft : AppColors.surfaceElevated,
                    border: Border.all(
                      color: color,
                      width: isCurrent ? 2 : 1.5,
                    ),
                  ),
                  child: completed
                      ? const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: AppColors.accent,
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: completed
                          ? AppColors.accent.withValues(alpha: 0.45)
                          : AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  color: completed
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
