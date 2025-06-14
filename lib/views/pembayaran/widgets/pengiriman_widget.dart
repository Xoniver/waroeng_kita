import 'package:flutter/material.dart';

class ShippingWidget extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;

  const ShippingWidget({
    super.key,
    this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = <Map<String,String>>[
      { 'label': 'Waroeng Kita', 'asset': 'assets/icons/logo_wk.png' },
      { 'label': 'Gojek',        'asset': 'assets/icons/logo_gojek.png' },
      { 'label': 'Grab',         'asset': 'assets/icons/logo_grab.png' },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengiriman*',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...options.map((opt) {
            final label = opt['label']!;
            final asset = opt['asset']!;
            return RadioListTile<String>(
              value: label,
              groupValue: selected,
              onChanged: onChanged,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Row(
                children: [
                  Image.asset(asset, width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(label, style: const TextStyle(fontSize: 14)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
