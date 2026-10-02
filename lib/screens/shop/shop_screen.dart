import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../data/user_preferences.dart';
import '../../l10n/l10n_ext.dart';
import '../../widgets/personalized_shop_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/shop_product_visuals.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final products = MockData.personalizedProducts(
      UserPreferences.instance.environments,
    );
    final featured = products.first;
    final rest = products.skip(1).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/explore');
            }
          },
        ),
        title: Text(l10n.sectionShop),
        actions: [
          TextButton(
            onPressed: () => context.push('/orders'),
            child: Text(l10n.myOrders),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            shopProductHeadline(l10n, featured),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ShopProductHeroCard(
            product: featured,
            width: double.infinity,
            height: 300,
            featured: true,
          ),
          const SizedBox(height: 28),
          SectionHeader(title: l10n.sectionShop),
          const SizedBox(height: 8),
          Text(
            l10n.shopHeadlineDelivery(MockData.deliveryArea),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          for (final product in rest) ...[
            ShopProductImageRow(product: product),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
