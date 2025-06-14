import 'package:flutter/material.dart';
import 'package:waroeng_kita/views/stok/widgets/list_produk.dart';
import 'package:waroeng_kita/views/stok/widgets/stok_search_widget.dart';

class StockView extends StatelessWidget {
  const  StockView({super.key});

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
        title: const Text(
          'Stok',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/notifications', (route) => false);
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
            StokSearchWidget(),
            SizedBox(height: 16),
            Expanded(child: ListProduk()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke form tambah produk
          Navigator.pushNamedAndRemoveUntil(context, '/stok-new', (route) => false);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
