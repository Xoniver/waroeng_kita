import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/daftar_produk_controller.dart';

class ListProduk extends StatefulWidget {
  const ListProduk({super.key});

  @override
  State<ListProduk> createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
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
                // aksi ketika produk diklik
              },
              child: Card(
                color: Colors.white,
                elevation: 1,
                shadowColor: Colors.black.withOpacity(0.9),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: AssetImage(produk.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Agar harga di kiri dan stok di kanan
                                  crossAxisAlignment: CrossAxisAlignment.center, // Untuk alignment vertikal item di dalam Row
                                  children: [
                                    Text(
                                      produk.price,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Stok ${produk.totalItem}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  produk.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
}
