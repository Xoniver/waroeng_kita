import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/views/pembayaran/widgets/alamat_widget.dart';
import 'package:waroeng_kita/views/pembayaran/widgets/list_produk_widget.dart';
import 'package:waroeng_kita/views/pembayaran/widgets/pembayaran_widget.dart';
import 'package:waroeng_kita/views/pembayaran/widgets/pengiriman_widget.dart';
import '../../controllers/cart_controller.dart';
import 'berhasil_pembayaran_view.dart';

class PembayaranView extends StatefulWidget {
  const PembayaranView({super.key});

  @override
  State<PembayaranView> createState() => _PembayaranViewState();
}

class _PembayaranViewState extends State<PembayaranView> {
  String? selectedShipping;
  String? selectedPayment;
  String note = '';

  bool get isFormValid {
    final cart = context.read<CartController>();
    return cart.items.isNotEmpty &&
        selectedShipping != null &&
        selectedPayment != null;
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Pengiriman', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/keranjang'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressWidget(),
            const Divider(),
            CartListWidget(items: cart.items),
            const Divider(),
            ShippingWidget(
              selected: selectedShipping,
              onChanged: (v) => setState(() => selectedShipping = v),
            ),
            const Divider(),
            PaymentMethodWidget(
              selected: selectedPayment,
              onChanged: (v) => setState(() => selectedPayment = v),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (v) => setState(() => note = v),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Catatan',
                  border: OutlineInputBorder(  borderSide: const BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(6)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ]),
        child: Row(
          children: [
            Text(
              cart.formattedTotalPrice,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Expanded(
              child: ElevatedButton(
                onPressed: isFormValid
                    ? () {
                  final cartController = Provider.of<CartController>(context, listen: false);

                  // Bersihkan keranjang
                  cartController.clearCart();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BerhasilPembayaranView(
                        shippingMethod: selectedShipping!,
                        paymentMethod: selectedPayment!,
                        totalPrice: cart.totalPrice,                      ),
                    ),
                  );

                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isFormValid ? Colors.green : Colors.grey.shade300,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Beli',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
