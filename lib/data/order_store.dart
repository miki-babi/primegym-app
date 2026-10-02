import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class OrderStore extends ChangeNotifier {
  OrderStore._();
  static final OrderStore instance = OrderStore._();

  static const _prefsKey = 'primegym_shop_orders';

  List<ShopOrder> _orders = [];

  List<ShopOrder> get orders => List.unmodifiable(_orders);

  ShopOrder? orderById(String id) {
    for (final order in _orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      final parsed = <ShopOrder>[];
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          parsed.add(ShopOrder.fromJson(item));
        } else if (item is Map) {
          parsed.add(ShopOrder.fromJson(Map<String, dynamic>.from(item)));
        }
      }
      parsed.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      instance._orders = parsed;
    } catch (_) {
      // Ignore corrupt storage for demo.
    }
  }

  Future<ShopOrder> createPaidOrder({
    required ShopProduct product,
    required String productTitle,
    required String deliveryArea,
    String phone = '',
    String? chapaRefPrefix,
  }) async {
    final now = DateTime.now();
    final id =
        'ord_${now.millisecondsSinceEpoch}_${_orders.length + 1}';
    final prefix = chapaRefPrefix ?? 'CHAPA-DEMO';
    final ref =
        '$prefix-${now.millisecondsSinceEpoch.toString().substring(7)}';
    final order = ShopOrder(
      id: id,
      productId: product.id,
      productTitle: productTitle,
      productImageAsset: product.imageAsset,
      priceEtb: product.priceEtb,
      phone: phone,
      deliveryArea: deliveryArea,
      status: ShopOrderStatus.paid,
      createdAt: now,
      chapaRef: ref,
    );
    _orders = [order, ..._orders];
    notifyListeners();
    await _persist();
    return order;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(_orders.map((o) => o.toJson()).toList());
    await prefs.setString(_prefsKey, payload);
  }
}
