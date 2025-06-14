import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/produk_detail/widgets/product_detail_bottom_widget.dart';
import 'package:waroeng_kita/views/produk_detail/widgets/product_detail_content_widget.dart';
import '../../controllers/cart_controller.dart';
import '../../models/product_model.dart';

class ProdukDetailView extends StatefulWidget {
  final DaftarProduk produk;
  const ProdukDetailView({super.key,
    required this.produk,
  });

  @override
  State<ProdukDetailView> createState() => _ProdukDetailViewState();
}

class _ProdukDetailViewState extends State<ProdukDetailView> {
  int _qty = 1;

  void _incrementQty() => setState(() => _qty++);
  void _decrementQty() {
    if (_qty > 1) setState(() => _qty--);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    final inCart = cart.items.any((c) => c.produk == widget.produk);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),

          // icon cart dengan badge kecil oranye
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () => Navigator.pushNamed(context, '/keranjang'),
              ),
              if (inCart)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          Expanded(
            child: ProductDetailContentWidget(
              produk: widget.produk,
              qty: _qty,
              onIncrement: _incrementQty,
              onDecrement: _decrementQty,
            ),
          ),
          ProductDetailBottomWidget(
            produk: widget.produk,
            qty: _qty,
            onAddToCart: () {
              context.read<CartController>().addToCart(widget.produk, _qty);

              // Tampilkan snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produk berhasil ditambahkan ke keranjang'),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
