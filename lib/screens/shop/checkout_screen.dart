import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../data/order_store.dart';
import '../../l10n/l10n_ext.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/personalized_shop_card.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.productId});

  final String productId;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _paying = false;

  Future<void> _payWithTelebirr(ShopProduct product) async {
    if (_paying) return;
    setState(() => _paying = true);
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    if (!mounted) return;

    final locale = Localizations.localeOf(context);
    final order = await OrderStore.instance.createPaidOrder(
      product: product,
      productTitle: product.title.resolve(locale),
      deliveryArea: MockData.deliveryArea,
      chapaRefPrefix: 'TELEBIRR-CHAPA',
    );

    if (!mounted) return;
    setState(() => _paying = false);
    await _showSuccess(order);
  }

  Future<void> _confirmManualPayment(ShopProduct product) async {
    final locale = Localizations.localeOf(context);
    final order = await OrderStore.instance.createPaidOrder(
      product: product,
      productTitle: product.title.resolve(locale),
      deliveryArea: MockData.deliveryArea,
      chapaRefPrefix: 'MANUAL-CHAPA',
    );
    if (!mounted) return;
    await _showSuccess(order);
  }

  Future<void> _showManualSteps(ShopProduct product) async {
    final l10n = context.l10n;
    final amount = l10n.shopPriceEtb(formatShopPrice(product.priceEtb));
    final code = product.id.toUpperCase();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final sheetL10n = sheetContext.l10n;
        final textTheme = Theme.of(sheetContext).textTheme;
        final steps = [
          sheetL10n.checkoutManualStep1,
          sheetL10n.checkoutManualStep2(amount),
          sheetL10n.checkoutManualStep3(code),
          sheetL10n.checkoutManualStep4,
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(sheetL10n.checkoutManualTitle, style: textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  sheetL10n.checkoutManualIntro,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                for (var i = 0; i < steps.length; i++) ...[
                  _ManualStep(index: i + 1, label: steps[i]),
                  if (i < steps.length - 1) const SizedBox(height: 12),
                ],
                const SizedBox(height: 24),
                PgButton(
                  label: sheetL10n.checkoutManualConfirm,
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    _confirmManualPayment(product);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSuccess(ShopOrder order) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final l10n = sheetContext.l10n;
        final textTheme = Theme.of(sheetContext).textTheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF7B84A), AppColors.accent],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF1A1200),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.paymentSuccessTitle, style: textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                l10n.paymentSuccessBody,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              PgButton(
                label: l10n.trackOrder,
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  context.go('/orders/${order.id}');
                },
              ),
              const SizedBox(height: 12),
              PgButton(
                label: l10n.done,
                variant: PgButtonVariant.secondary,
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  context.go('/shop');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final product = MockData.productById(widget.productId);

    if (product == null) {
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
          title: Text(l10n.checkoutTitle),
        ),
        body: Center(child: Text(l10n.checkoutProductMissing)),
      );
    }

    final title = product.title.resolve(locale);
    final blurb = product.blurb.resolve(locale);
    final price = l10n.shopPriceEtb(formatShopPrice(product.priceEtb));
    final compareAt = product.compareAtPriceEtb;
    final headline = shopProductHeadline(l10n, product);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: AppColors.background,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
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
                        size: 56,
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x66000000),
                          Color(0x14000000),
                          Color(0xF2000000),
                        ],
                        stops: [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.hasDiscount)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              l10n.shopDiscountPercent(
                                product.discountPercent,
                              ),
                              style: textTheme.labelLarge?.copyWith(
                                color: const Color(0xFF1A1200),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        Text(
                          headline,
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          title,
                          style: textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (compareAt != null && product.hasDiscount) ...[
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          l10n.shopPriceEtb(formatShopPrice(compareAt)),
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.textMuted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: Icons.local_shipping_rounded,
                      label: l10n.checkoutFreeDeliveryBadge,
                    ),
                    _InfoChip(
                      icon: Icons.location_on_rounded,
                      label: MockData.deliveryArea,
                    ),
                    _InfoChip(
                      icon: Icons.lock_rounded,
                      label: l10n.checkoutSecurePay,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  blurb,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                Text(l10n.checkoutIncludes, style: textTheme.titleMedium),
                const SizedBox(height: 12),
                PgCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _IncludeRow(
                        icon: shopProductIcon(product.kind),
                        label: title,
                      ),
                      const SizedBox(height: 12),
                      _IncludeRow(
                        icon: Icons.local_shipping_outlined,
                        label: l10n.checkoutDeliverTo(
                          MockData.deliveryArea,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _IncludeRow(
                        icon: Icons.verified_rounded,
                        label: l10n.checkoutPoweredByChapa,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: PgButton(
                        label: _paying
                            ? l10n.checkoutPayingTelebirr
                            : l10n.checkoutPayWithTelebirr,
                        onPressed: _paying
                            ? null
                            : () => _payWithTelebirr(product),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PgButton(
                        label: l10n.checkoutPayManually,
                        variant: PgButtonVariant.secondary,
                        onPressed: _paying
                            ? null
                            : () => _showManualSteps(product),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    l10n.checkoutPoweredByChapa,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _IncludeRow extends StatelessWidget {
  const _IncludeRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _ManualStep extends StatelessWidget {
  const _ManualStep({required this.index, required this.label});

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.accentSoft,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(label, style: textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
