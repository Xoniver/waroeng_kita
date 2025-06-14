import 'package:flutter/material.dart';

import '../../global_widget/custom_textfield_widget.dart';

class AlamatView extends StatefulWidget {
  const AlamatView({super.key});

  @override
  State<AlamatView> createState() => _AlamatViewState();
}

class _AlamatViewState extends State<AlamatView> {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Bagian atas: background gradient dan logo
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1D4AAA), Color(0xFF7DC3F7)],
              ),
            ),
            child: Center(
              child: Image.asset('assets/images/logo.png', width: 200),
            ),
          ),

          // Bagian bawah: Form alamat
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Back Button dan Title
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Alamat',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      'Berikan alamat yang lengkap dan sesuai dengan alamat yang akan didatangi untuk mengirim produk yang dipesan',
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),


                    const SizedBox(height: 24),

                    CustomTextField(
                      label: 'Alamat Lengkap',
                      controller: addressController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 100),
                    const SizedBox(height: 40),
                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/printer', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5CB661),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }}

