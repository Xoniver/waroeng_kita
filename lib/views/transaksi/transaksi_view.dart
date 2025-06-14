import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/daftar_produk_controller.dart';
import '../home/widgets/home_header_widget.dart';

class TransaksiView extends StatefulWidget {
  final int initialTabIndex;
  const TransaksiView({
    super.key,
    this.initialTabIndex = 0,
  });


  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  late int selectedTabIndex;
  int selectedSubTabIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedTabIndex = widget.initialTabIndex;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(child:
      Column(
        children: [
          const HomeHeaderWidget(),

          const SizedBox(height: 12),

          // Tab Report & Transaksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(28),
              ),
              height: 42,
              child: Row(
                children: [
                  _buildMainTab("Report", 0),
                  _buildMainTab("Transaksi", 1),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Card ringkasan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildSummaryCard("Pengeluaran", "Rp 401.000", const Color(0xFFCB6134)),
                const SizedBox(width: 12),
                _buildSummaryCard("Pemasukan", "Rp 497.000", const Color(0xFF00A86B)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Konten utama
          selectedTabIndex == 0
              ? _buildReportTab(context)
              : _buildTransaksiTab(context),
        ],
      ),
      ));
  }

  Widget _buildMainTab(String title, int index) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00A86B) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Bar Chart
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Row(
                    children: [
                      _buildBarOnly(100, const Color(0xFFCB6134)),
                      const SizedBox(width: 0),
                      _buildBarOnly(140, const Color(0xFF00A86B)),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pengeluaran", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Pemasukan", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Sub-tab
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                _buildSubTab("Pengeluaran", 0),
                _buildSubTab("Pemasukan", 1),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // List dari Provider
          Consumer<DaftarProdukController>(
            builder: (context, controller, child) {
              final list = controller.listdaftarProduk;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length-4,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100, // batas aman agar tidak menyebabkan overflow
                          child: Text(
                            item.price,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )


        ],
      ),
    );
  }

  Widget _buildTransaksiTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Riwayat",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Consumer<DaftarProdukController>(
            builder: (context, controller, child) {
              final list = controller.listdaftarProduk;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return GestureDetector(
                      onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/detail-transaksi', (route) => false);
                  },child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCB6134),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.price,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                item.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text("Lihat Detail", style: TextStyle(color: Colors.white)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                          ],
                        )
                      ],
                    ),
                  )
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBarOnly(double height, Color color) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Container(
            height: height,
            width: 50,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildSubTab(String title, int index) {
    final isSelected = selectedSubTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedSubTabIndex = index),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFCB6134) : Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
