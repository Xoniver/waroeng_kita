// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/kasir/pages/success_utang_pembayaran.dart';

import '../../controllers/kasir_controller.dart';

class PembayaranKasirView extends StatefulWidget {
  const PembayaranKasirView({super.key});

  @override
  State<PembayaranKasirView> createState() => _PembayaranKasirViewState();
}

class _PembayaranKasirViewState extends State<PembayaranKasirView> {
  @override
  Widget build(BuildContext context) {
    final kasirController = Provider.of<KasirController>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/kasir', (route) => false);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Pembayaran', style: TextStyle(color: Colors.black)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Total Pembayaran - Center dan Column
            Center(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Column(
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatRupiah(kasirController.totalPrice),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Pilih Pembayaran
            const Text(
              'Pilih Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Cash'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/cash-pembayaran', arguments: kasirController.totalPrice.toInt());

              },
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Utang'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                final kasirController = Provider.of<KasirController>(context, listen: false);

                // Simpan total sebelum keranjang dibersihkan
                final int totalBill = kasirController.totalPrice.toInt();

                // Bersihkan keranjang
                kasirController.clearCart();

                // Navigasi ke halaman success
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessPembayaranUtang(
                      totalBill: totalBill,
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // Tombol Hapus Transaksi - Full Width
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  kasirController.clearCart();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCB6134),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Hapus Transaksi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Teks putih
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
