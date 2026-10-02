import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_data.dart';
import '../l10n/l10n_ext.dart';
import '../models/models.dart';

IconData shopProductIcon(ShopProductKind kind) {
  return switch (kind) {
    ShopProductKind.protein => Icons.local_drink_rounded,
    ShopProductKind.homeKit => Icons.fitness_center_rounded,
    ShopProductKind.accessory => Icons.sports_gymnastics_rounded,
  };
}

String shopProductHeadline(AppLocalizations l10n, ShopProduct product) {
  return switch (product.kind) {
    ShopProductKind.protein =>
      l10n.shopHeadlineProtein(MockData.currentUser),
    ShopProductKind.homeKit => l10n.shopHeadlineNoEquipment,
    ShopProductKind.accessory =>
      l10n.shopHeadlineDelivery(MockData.deliveryArea),
  };
}

void openShopCheckout(BuildContext context, ShopProduct product) {
  context.push('/checkout/${product.id}');
}

String formatShopPrice(int priceEtb) {
  final raw = priceEtb.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final fromEnd = raw.length - i;
    buffer.write(raw[i]);
    if (fromEnd > 1 && fromEnd % 3 == 1) {
      buffer.write(',');
    }
  }
  return buffer.toString();
}
