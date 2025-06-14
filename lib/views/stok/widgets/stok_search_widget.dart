import 'package:flutter/material.dart';

class StokSearchWidget extends StatelessWidget {
  const StokSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 380),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 160,
                child:
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  ),
                ),
              ),),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.only(
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
    );
  }
}
