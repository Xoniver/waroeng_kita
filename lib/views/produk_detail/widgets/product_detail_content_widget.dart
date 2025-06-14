import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductDetailContentWidget extends StatelessWidget {
  final DaftarProduk produk;
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ProductDetailContentWidget({
    super.key,
    required this.produk,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(padding: EdgeInsets.all(12),child:
    ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24),
          bottom: Radius.circular(24)),
      child: Image.asset(
        produk.imagePath,
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
      ),
    ),),
          Text(
            produk.price,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            produk.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            produk.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // *** Qty Selector ***
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _qtyButton('-', onDecrement),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$qty',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              _qtyButton('+', onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(String symbol, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          symbol,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
