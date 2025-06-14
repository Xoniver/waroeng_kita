import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';
import '../../../controllers/cart_controller.dart';
import 'package:waroeng_kita/constants/textstyle_constant.dart';

class ProductDetailBottomWidget extends StatefulWidget {
  final DaftarProduk produk;
  final int qty;
  final VoidCallback onAddToCart;

  const ProductDetailBottomWidget({
    super.key,
    required this.produk,
    required this.qty,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailBottomWidget> createState() => _ProductDetailBottomWidgetState();
}

class _ProductDetailBottomWidgetState extends State<ProductDetailBottomWidget> {
  @override
  Widget build(BuildContext context) {
    // Pantau cart untuk badge
    final cart = context.watch<CartController>();
    final inCart = cart.items.any((c) => c.produk == widget.produk);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          // Icon button dengan drop shadow & badge
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                  onPressed: () {
                    Navigator.pushNamed(context, '/keranjang');
                  },
                ),
                if (inCart)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Tombol + Keranjang (primary)
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '+ Keranjang',
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
