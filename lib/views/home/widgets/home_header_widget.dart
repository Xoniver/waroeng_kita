// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/controllers/cart_controller.dart'; // ← import CartController
import 'package:waroeng_kita/controllers/scale_factor_controller.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = Provider.of<ScaleFactorController>(context).scaleHelper;
    final screenWidth = MediaQuery.of(context).size.width;

    const iconsAndSpacingWidth = 28 + 8 + 28 + 32; // notif + spacer + cart + margin
    const horizontalPadding = 32; // padding kiri+kanan
    final maxSearchWidth = screenWidth - iconsAndSpacingWidth - horizontalPadding;

    // Pantau cart untuk badge
    final cart = context.watch<CartController>();
    final hasItems = cart.items.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxSearchWidth),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Aksi cari
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cari'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.notifications_none, size: 28),
          const SizedBox(width: 8),
          // Cart icon with badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                onPressed: () {
                  Navigator.pushNamed(context, '/keranjang');
                },
              ),
              if (hasItems)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
