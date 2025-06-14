import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:intl/intl.dart';

String formatRupiah(num number) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  return formatter.format(number);
}

class KasirController with ChangeNotifier {
  final Map<DaftarProduk, int> _items = {};

  Map<DaftarProduk, int> get items => _items;

  void addToCart(DaftarProduk produk) {
    if (_items.containsKey(produk)) {
      _items[produk] = _items[produk]! + 1;
    } else {
      _items[produk] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(DaftarProduk produk) {
    if (_items.containsKey(produk)) {
      _items[produk] = _items[produk]! - 1;
      if (_items[produk]! <= 0) {
        _items.remove(produk);
      }
      notifyListeners();
    }
  }

  int getQuantity(DaftarProduk produk) => _items[produk] ?? 0;

  double get totalPrice {
    double total = 0;
    _items.forEach((produk, qty) {
      total += double.parse(produk.price.replaceAll('.', '').replaceAll('Rp ', '')) * qty;
    });
    return total;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
