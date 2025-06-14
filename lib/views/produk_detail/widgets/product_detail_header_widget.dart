import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class ProductDetailHeaderWidget extends StatelessWidget {
  final DaftarProduk produk;
  const ProductDetailHeaderWidget({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(12),child:
    ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24),
        bottom: Radius.circular(24)),
    child: Image.asset(
    produk.imagePath,
    width: double.infinity,
    height: 240,
    fit: BoxFit.cover,
    ),
    ),);
  }
}
