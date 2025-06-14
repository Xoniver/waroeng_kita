import 'package:flutter/material.dart';

class DetailTransaksiPage extends StatelessWidget {
  const DetailTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background seluruh halaman
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/navigation-bar',
              arguments: {
                'initialIndex': 2,
                'transaksiInitialTabIndex': 1,
              },
            );
          },
        ),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 16),
          Icon(Icons.shopping_cart),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    "Detail Transaksi",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "20 Mei 2025, 11:30 WIB",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildRow("Pengiriman", "WaroengKita"),
            const Divider(),
            _buildRow("Pembayaran", "BNI Virtual Account"),
            const Divider(),
            _buildRow("Total Bill", "Rp 25.000"),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              "Detail Transaksi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildRow("Jenang", "Rp 25.000"),
            const SizedBox(height: 12),
            _buildRow("Total (1 Produk)", "Rp 25.000"),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String leftText, String rightText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText, style: const TextStyle(fontSize: 16)),
          Text(rightText, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
