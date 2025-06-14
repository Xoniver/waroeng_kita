import 'package:flutter/material.dart';
import 'package:intl/intl.dart';               // ← import intl
import '../models/product_model.dart';

class CartItem {
  final DaftarProduk produk;
  int qty;
  CartItem({required this.produk, this.qty = 1});
}

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  void addToCart(DaftarProduk produk, int qty) {
    final index = _items.indexWhere((c) => c.produk == produk);
    if (index >= 0) {
      _items[index].qty += qty;
    } else {
      _items.add(CartItem(produk: produk, qty: qty));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.qty++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0, (sum, c) {
      final price = int.tryParse(c.produk.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + price * c.qty;
    }).toDouble();
  }

  /// Formatted string dengan titik ribuan, tanpa desimal
  String get formattedTotalPrice {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(totalPrice);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

