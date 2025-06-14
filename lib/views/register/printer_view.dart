import 'package:flutter/material.dart';

import '../../global_widget/custom_dropdown_widget.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({super.key});

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  final List<String> printerList = [
    'Epson L120',
    'Canon PIXMA G2010',
    'Brother HL-1201',
    'HP LaserJet Pro',
    'Thermal Printer X58'
  ];

  String? selectedPrinter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Bagian atas: background gradient dan logo
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
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

          // Bagian bawah: Dropdown printer
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/alamat', (route) => false);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Pair Printer',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    Center(child: Text(
                      'Pair Printer yang akan sering digunakan',
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),

                    const SizedBox(height: 24),

                    // Dropdown Printer
                    CustomDropdown(
                      value: selectedPrinter,
                      items: printerList,
                      hint: 'Pilih Printer',
                      onChanged: (value) {
                        setState(() {
                          selectedPrinter = value;
                        });
                      },
                    ),

                    const SizedBox(height: 150),
                    // Tombol skip
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/navigation-bar', (route) => false);

                          if (selectedPrinter != null) {
                            // Lanjut ke proses berikutnya
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D4AAA),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tombol Next
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);

                          if (selectedPrinter != null) {
                            // Lanjut ke proses berikutnya
                          }
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
                          'Lest Go!',
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


