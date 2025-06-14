import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../home/widgets/home_header_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage;
  final picker = ImagePicker();

  final TextEditingController _namaController = TextEditingController(text: 'John Doe');
  final TextEditingController _emailController = TextEditingController(text: 'john.doe@example.com');
  final TextEditingController _alamatController = TextEditingController(text: 'Jl. Merdeka No. 123');

  final List<String> printerList = [
    'Epson L120',
    'Canon PIXMA G2010',
    'Brother HL-1201',
    'HP LaserJet Pro',
    'Thermal Printer X58'
  ];
  String? selectedPrinter;

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
                    setState(() => _profileImage = File(pickedFile.path));
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
                    setState(() => _profileImage = File(result.files.single.path!));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        decoration: InputDecoration(
          labelText: label,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            HomeHeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile Picture with edit icon
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(65),
                              color: Colors.grey.shade100,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(65),
                              child: _profileImage == null
                                  ? Image.asset('assets/images/profile_tumbnail.png', fit: BoxFit.cover)
                                  : Image.file(_profileImage!, fit: BoxFit.cover),
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
                              padding: const EdgeInsets.all(6),
                              child: const Icon(Icons.edit, size: 22, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // TextFields
                    _buildTextField('Nama', _namaController),
                    _buildTextField('Email', _emailController),
                    _buildTextField('Alamat', _alamatController),

                    const SizedBox(height: 16),

                    // Dropdown printer
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedPrinter,
                        hint: const Text('Pilih Printer'),
                        underline: const SizedBox(),
                        items: printerList.map((printer) {
                          return DropdownMenuItem(
                            value: printer,
                            child: Text(printer),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPrinter = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile berhasil disimpan')),
                    );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A63CB),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ubah', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
                  const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFCB6134),
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Keluar', style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
                ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}

