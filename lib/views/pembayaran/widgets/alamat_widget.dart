import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // di aplikasi nyata, ini akan dinamis
    final alamat = 'Besuki Kidul, Jatiluhur, Kec. Rowokele, Kabupaten Kebumen';

    return ListTile(
      title: const Text('Alamat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(alamat, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.keyboard_arrow_down),
      onTap: () {
        // TODO: open address selector
      },
    );
  }
}
