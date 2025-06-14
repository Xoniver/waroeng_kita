import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_controller.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Image.asset(item.produk.imagePath, width: 60, height: 60, fit: BoxFit.cover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.produk.price, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(item.produk.name),
                  ],
                ),
              ),
              Row(
                children: [
                  _qtyButton("-", () => cart.decrement(item)),
                  const SizedBox(width: 8),
                  Text('${item.qty}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  _qtyButton("+", () => cart.increment(item)),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
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
        child: Text(symbol, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
