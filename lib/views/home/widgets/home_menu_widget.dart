import 'package:flutter/material.dart';

class HomeMenuWidget extends StatefulWidget {
  const HomeMenuWidget({super.key});

  @override
  State<HomeMenuWidget> createState() => _HomeMenuWidgetState();
}

class _HomeMenuWidgetState extends State<HomeMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem(
            context,
            icon: Icons.inventory_2,
            label: 'Stok',
            routeName: '/stok',
            tabIndex: 0,
          ),
          _buildMenuItem(
            context,
            icon: Icons.point_of_sale,
            label: 'Kasir',
            routeName: '/kasir',
            tabIndex: 0,
          ),
          _buildMenuItem(
            context,
            icon: Icons.receipt_long,
            label: 'Laporan',
            routeName: '/navigation-bar',
            tabIndex: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String routeName,
        required int tabIndex,
      }) {
    return GestureDetector(
      onTap: () {
        if (label == 'Laporan') {
          // Khusus menu Laporan, kirim 2 parameter
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeName,
                (route) => false,
            arguments: {
              'initialIndex': 2,
              'transaksiInitialTabIndex': 0,
            },
          );
        } else {
          // Menu lain tetap seperti biasa
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeName,
                (route) => false,
            arguments: tabIndex,
          );
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.green[700], size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
