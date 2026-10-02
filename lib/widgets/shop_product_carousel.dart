import 'package:flutter/material.dart';

import '../models/models.dart';
import 'shop_product_visuals.dart';

class ShopProductCarousel extends StatelessWidget {
  const ShopProductCarousel({
    super.key,
    required this.products,
  });

  final List<ShopProduct> products;

  static const double cardHeight = 336;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight + 24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ShopProductHeroCard(
            product: products[index],
            height: cardHeight,
            featured: index == 0,
          );
        },
      ),
    );
  }
}
