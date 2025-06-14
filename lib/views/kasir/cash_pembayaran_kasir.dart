import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/kasir/pages/success_cash_pembayaran.dart';
import '../../../controllers/kasir_controller.dart'; // pastikan path-nya sesuai

class CashPembayaranKasir extends StatefulWidget {
  final int totalPembayaran;

  const CashPembayaranKasir({super.key, required this.totalPembayaran});

  @override
  State<CashPembayaranKasir> createState() => _CashPembayaranKasirState();
}

class _CashPembayaranKasirState extends State<CashPembayaranKasir> {
  final TextEditingController _controller = TextEditingController();
  int _jumlahDibayar = 0;

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _setJumlah(int jumlah) {
    setState(() {
      _jumlahDibayar = jumlah;
      _controller.text = currencyFormatter.format(jumlah);
    });
  }

  void _onInputChanged(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    int jumlah = int.tryParse(digitsOnly) ?? 0;

    setState(() {
      _jumlahDibayar = jumlah;
      _controller.value = TextEditingValue(
        text: currencyFormatter.format(jumlah),
        selection: TextSelection.collapsed(offset: currencyFormatter.format(jumlah).length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isBayarEnabled = _jumlahDibayar >= widget.totalPembayaran;
    final buttonColor = const Color(0xFF2A63CB);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      const Text('Total Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        currencyFormatter.format(widget.totalPembayaran),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Masukkan Jumlah Uang', style: TextStyle(color: Colors.grey)),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: _onInputChanged,
              decoration: const InputDecoration(
                hintText: 'Masukkan jumlah uang',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _setJumlah(widget.totalPembayaran),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Uang Pas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Jumlah Lain', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [10000, 20000, 50000, 100000].map((e) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () => _setJumlah(_jumlahDibayar + e),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        currencyFormatter.format(e),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isBayarEnabled
                    ? () {
                  // Ambil controller
                  final kasirController = Provider.of<KasirController>(context, listen: false);

                  // Bersihkan keranjang
                  kasirController.clearCart();

                  // Navigasi ke halaman sukses
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessPembayaranCash(
                        totalBill: widget.totalPembayaran,
                        jumlahPembayaran: _jumlahDibayar,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isBayarEnabled ? const Color(0xFF00A86B) : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Bayar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
