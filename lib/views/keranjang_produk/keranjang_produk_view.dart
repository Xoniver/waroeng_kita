import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/keranjang_produk/widgets/cart_item_widget.dart';

import '../../controllers/cart_controller.dart';
import '../home/widgets/home_list_product_widget.dart';

class KeranjangProdukView extends StatelessWidget {
  const KeranjangProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<CartController>(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: const Text('Keranjang', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.grey.withOpacity(0.5),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, '/notifications'),
            ),
            // cart icon kita biarkan statis di sini
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: Consumer<CartController>(
          builder: (context, cart, _) {
            final items = cart.items;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (items.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'List Produk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...items.map((item) => CartItemWidget(item: item)),
                  ] else
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('Keranjang kosong')),
                    ),
                  SizedBox(height: 16),
                  // Rekomendasi
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Rekomendasi Produk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const HomeProductWidget(),
                ],
              ),
            );
          },
        ),

        // bottom bar dengan tombol Beli
        bottomNavigationBar: Consumer<CartController>(
          builder: (_, cart, __) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Text(
                    cart.formattedTotalPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          cart.items.isNotEmpty
                              ? () {
                                // TODO: checkout
                                Navigator.pushNamed(context, '/pembayaran');
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            cart.items.isNotEmpty
                                ? Colors.green
                                : Colors.grey.shade300,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Beli',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
