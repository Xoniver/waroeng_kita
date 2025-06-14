import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/daftar_produk_controller.dart';
import '../../../controllers/kasir_controller.dart';

class ListProdukKasir extends StatefulWidget {
  const ListProdukKasir({super.key});

  @override
  State<ListProdukKasir> createState() => _ListProdukKasirState();
}

class _ListProdukKasirState extends State<ListProdukKasir> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DaftarProdukController>(
      builder: (context, produkController, child) {
        return ListView.builder(
          itemCount: produkController.listdaftarProduk.length,
          itemBuilder: (context, index) {
            final produk = produkController.listdaftarProduk[index];
            return GestureDetector(
              onTap: () {
                final cartController = context.read<KasirController>();

                // Hanya tambahkan jika produk belum ada di cart
                if (cartController.getQuantity(produk) == 0) {
                  cartController.addToCart(produk);
                }
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Material(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets, // handle keyboard
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Consumer<KasirController>(
                            builder: (context, cartController, child) {
                              int qty = cartController.getQuantity(produk);
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          produk.imagePath,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              produk.price,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              produk.name,
                                              style: const TextStyle(fontSize: 16),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Row(
                                        children: [
                                          _qtyButton('-', () {
                                            cartController.removeFromCart(produk);
                                          }),
                                          const SizedBox(width: 8),
                                          Text(
                                            '$qty',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          _qtyButton('+', () {
                                            cartController.addToCart(produk);
                                          }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Consumer<KasirController>(
                                    builder: (_, cart, __) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              formatRupiah(cart.totalPrice.toInt()),                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: cart.items.isNotEmpty
                                                    ? () {
                                                  Navigator.pushNamed(context, '/pembayaran-kasir');
                                                }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: cart.items.isNotEmpty
                                                      ? Colors.green
                                                      : Colors.grey.shade300,
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
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 3,
                shadowColor: Colors.black.withOpacity(1),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(produk.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  produk.price,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  produk.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _qtyButton(String symbol, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          symbol,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  String formatRupiah(int number) {
    return 'Rp${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}
