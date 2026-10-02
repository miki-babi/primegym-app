import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/order_store.dart';
import '../../l10n/l10n_ext.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/personalized_shop_card.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final orders = OrderStore.instance.orders;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/shop');
            }
          },
        ),
        title: Text(l10n.myOrders),
      ),
      body: orders.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_shipping_outlined,
                    size: 48,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.ordersEmptyTitle, style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    l10n.ordersEmptyBody,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PgButton(
                    label: l10n.browseShop,
                    onPressed: () => context.push('/shop'),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              itemCount: orders.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                return _OrderListCard(order: order);
              },
            ),
    );
  }
}

class _OrderListCard extends StatelessWidget {
  const _OrderListCard({required this.order});

  final ShopOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final price = l10n.shopPriceEtb(formatShopPrice(order.priceEtb));

    return PgCard(
      onTap: () => context.push('/orders/${order.id}'),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 56,
              height: 56,
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
                const SizedBox(height: 4),
                Text(
                  orderStatusLabel(l10n, order.status),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}

String orderStatusLabel(AppLocalizations l10n, ShopOrderStatus status) {
  return switch (status) {
    ShopOrderStatus.paymentInitiated => l10n.orderStatusPaymentInitiated,
    ShopOrderStatus.paid => l10n.orderStatusPaid,
    ShopOrderStatus.preparing => l10n.orderStatusPreparing,
    ShopOrderStatus.outForDelivery => l10n.orderStatusOutForDelivery,
    ShopOrderStatus.delivered => l10n.orderStatusDelivered,
  };
}
