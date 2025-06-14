import 'package:flutter/material.dart';
import '../../../controllers/cart_controller.dart';

class CartListWidget extends StatelessWidget {
  final List<CartItem> items;
  const CartListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text('List Produk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        ...items.map((c) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(c.produk.imagePath, width: 60, height: 60, fit: BoxFit.cover),
            ),
            title: Text(c.produk.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            subtitle: Text(c.produk.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            trailing: Text('${c.qty}', style: const TextStyle(fontSize: 16)),
          );
        }),
      ],
    );
  }
}
