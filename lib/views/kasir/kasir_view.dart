import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/kasir/widgets/listproduk_kasir,widget.dart';

import '../../controllers/kasir_controller.dart';
import '../stok/widgets/stok_search_widget.dart';

class KasirView extends StatefulWidget {
  const KasirView({super.key});

  @override
  State<KasirView> createState() => _KasirViewState();
}

class _KasirViewState extends State<KasirView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/navigation-bar', (route) => false);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),),
        title: const StokSearchWidget(),        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),

        actions: [
          GestureDetector(
            onTap: () {
            },
            child: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/cart', (route) => false);
            },
            child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            SizedBox(height: 16),
            Expanded(child: ListProdukKasir()),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<KasirController>(
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
                  formatRupiah(cart.totalPrice),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    onPressed: cart.items.isNotEmpty
                        ? () {
                      // TODO: checkout
                      Navigator.pushNamed(context, '/pembayaran-kasir');
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      cart.items.isNotEmpty ? Colors.green : Colors.grey.shade300,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

    );

  }
}

