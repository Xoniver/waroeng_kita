import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String formatRupiah(String value) {
  // Hilangkan semua selain digit
  String digits = value.replaceAll(RegExp(r'[^0-9]'), '');

  if (digits.isEmpty) return '';

  // Parse ke int
  int number = int.parse(digits);

  // Format dengan pemisah ribuan
  final formatter = NumberFormat('#,###', 'id_ID');
  String formatted = formatter.format(number);

  return 'Rp $formatted';
}

class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {


  File? _image;
  final picker = ImagePicker();

  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _beliController = TextEditingController();
  final TextEditingController _jualController = TextEditingController();

  final FocusNode _beliFocus = FocusNode();
  final FocusNode _jualFocus = FocusNode();

  String? selectedKategori;
  final List<String> kategoriList = ['Makanan', 'Minuman', 'Lainnya'];

  bool isFormFilled = false;

  void checkFormFilled() {
    setState(() {
      isFormFilled = _kodeController.text.isNotEmpty &&
          _namaController.text.isNotEmpty &&
          _beliController.text.isNotEmpty &&
          _jualController.text.isNotEmpty &&
          selectedKategori != null &&
          _image != null;
    });
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() => _image = File(pickedFile.path));
                    checkFormFilled();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Ambil dari Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null && result.files.single.path != null) {
                    setState(() => _image = File(result.files.single.path!));
                    checkFormFilled();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool isHarga = false}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.25),
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: isHarga
            ? (hint.contains('Beli') ? _beliFocus : _jualFocus)
            : null,
        keyboardType: isHarga ? TextInputType.number : TextInputType.text,
        onChanged: (value) {
          if (isHarga) {
            final newText = formatRupiah(value);

            // Cek agar tidak infinite loop
            if (newText != controller.text) {
              controller.value = TextEditingValue(
                text: newText,
                selection: TextSelection.collapsed(offset: newText.length),
              );
            }
          }
          checkFormFilled();
        },
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }


  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/success.png', width: 100), // Ganti sesuai path
              const SizedBox(height: 16),
              const Text(
                'Barang berhasil ditambah',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop(); // Close dialog
      Navigator.pushNamedAndRemoveUntil(context, '/stok', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/stok', (route) => false);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Tambah Barang', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.5),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/notifications', (route) => false);
            },
            child: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/cart', (route) => false);
            },
            child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: const Color(0xFFF7F7F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: _image == null
                        ? const Icon(Icons.image, size: 60)
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.add, size: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField('Kode Produk', _kodeController),
            const SizedBox(height: 16),
            _buildTextField('Nama Produk', _namaController),
            const SizedBox(height: 16),
            _buildTextField('Harga Beli', _beliController, isHarga: true),
            const SizedBox(height: 16),
            _buildTextField('Harga Jual', _jualController, isHarga: true),
            const SizedBox(height: 16),
            _buildTextField('Jumlah Produk', _namaController),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ExpansionTile(
                title: Text(
                  selectedKategori == null ? 'Pilih Kategori' : selectedKategori!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: kategoriList.map((kategori) {
                  return RadioListTile<String>(
                    title: Text(kategori),
                    value: kategori,
                    groupValue: selectedKategori,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      setState(() {
                        selectedKategori = value;
                        checkFormFilled();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: isFormFilled ? _showSuccessPopup : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFormFilled ? Colors.blue : Colors.grey.shade300,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
