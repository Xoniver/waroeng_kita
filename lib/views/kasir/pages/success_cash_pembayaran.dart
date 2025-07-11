import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessPembayaranCash extends StatelessWidget {
  final int totalBill;
  final int jumlahPembayaran;

  const SuccessPembayaranCash({
    super.key,
    required this.totalBill,
    required this.jumlahPembayaran,
  });

  String get formattedTotalBill {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(totalBill);
  }

  String get formattedJumlahPembayaran {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(jumlahPembayaran);
  }

  String get formattedKembalian {
    final kembalian = jumlahPembayaran - totalBill;
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(kembalian);
  }

  String get formattedDate {
    final now = DateTime.now();
    return DateFormat('dd MMMM yyyy, HH:mm').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Pembayaran', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Center(
            child: Image.asset(
              'assets/images/success.png',
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pembayaran Sukses!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),

          const SizedBox(height: 24),
          _buildDetailRow('Pembayaran', 'Cash'),
          _buildDivider(),
          _buildDetailRow('Total Bill', formattedTotalBill),
          _buildDivider(),
          _buildDetailRow('Jumlah Uang', formattedJumlahPembayaran),
          _buildDivider(),
          _buildDetailRow('Kembalian', formattedKembalian),
          _buildDivider(),

          const Spacer(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/navigation-bar', (r) => false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => const Divider(height: 1);
}
