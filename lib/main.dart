import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waroeng_kita/controllers/daftar_produk_controller.dart';
import 'package:waroeng_kita/controllers/scale_factor_controller.dart';
import 'package:waroeng_kita/views/kasir/cash_pembayaran_kasir.dart';
import 'package:waroeng_kita/views/kasir/kasir_view.dart';
import 'package:waroeng_kita/views/kasir/pembayaran_kasir_view.dart';
import 'package:waroeng_kita/views/keranjang_produk/keranjang_produk_view.dart';
import 'package:waroeng_kita/views/login/login_view.dart';
import 'package:waroeng_kita/views/navigation_bar/navigation_bar_view.dart';
import 'package:waroeng_kita/views/onboarding/onboarding_view.dart';
import 'package:waroeng_kita/views/pembayaran/pembayaran_view.dart';
import 'package:waroeng_kita/views/register/alamat_view.dart';
import 'package:waroeng_kita/views/register/printer_view.dart';
import 'package:waroeng_kita/views/register/register_view.dart';
import 'package:waroeng_kita/views/splashscreen/splash_screen.dart';
import 'package:waroeng_kita/views/stok/stok_new.dart';
import 'package:waroeng_kita/views/stok/stok_view.dart';
import 'package:waroeng_kita/views/transaksi/detail_transaksi_view.dart';
import 'package:waroeng_kita/views/transaksi/transaksi_view.dart';

import 'controllers/cart_controller.dart';
import 'controllers/kasir_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScaleFactorController()),
        ChangeNotifierProvider(create: (_) => DaftarProdukController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => KasirController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waroeng Kita',
      theme: ThemeData(fontFamily: 'Lato'),
      home: const SplashScreen(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/onboarding':
            return MaterialPageRoute(builder: (_) => const OnboardingView());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterPage());
          case '/alamat':
            return MaterialPageRoute(builder: (_) => const AlamatView());
          case '/printer':
            return MaterialPageRoute(builder: (_) => const PrinterView());
          case '/navigation-bar':
            final args = settings.arguments as Map<String, dynamic>? ?? {};
            final initialIndex = args['initialIndex'] as int? ?? 0;
            final transaksiTab = args['transaksiInitialTabIndex'] as int? ?? 1;
            return MaterialPageRoute(
              builder: (_) => NavigationBarView(
                initialIndex: initialIndex,
                transaksiInitialTabIndex: transaksiTab,
              ),
            );
          case '/stok':
            return MaterialPageRoute(builder: (_) => const StockView());
          case '/stok-new':
            return MaterialPageRoute(builder: (_) => const TambahBarangScreen());
          case '/transaksi':
            return MaterialPageRoute(builder: (_) => const TransaksiView());
          case '/detail-transaksi':
            return MaterialPageRoute(
              builder: (_) => const DetailTransaksiPage(),
            );
          case '/keranjang':
            return MaterialPageRoute(
              builder: (_) => const KeranjangProdukView(),
            );
            case '/pembayaran':
            return MaterialPageRoute(
              builder: (_) => const PembayaranView(),
            );
          case '/kasir':
            return MaterialPageRoute(
              builder: (_) => const KasirView(),
            );
          case '/pembayaran-kasir':
            return MaterialPageRoute(
              builder: (_) => PembayaranKasirView(),
            );
          case '/cash-pembayaran':
            final total = settings.arguments as int? ?? 0;
            return MaterialPageRoute(builder: (_) => CashPembayaranKasir(totalPembayaran: total));

          default:
          // Fallback kalau route tidak ditemukan
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder( // Builder memberikan context yang memiliki navigator
                  builder: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Halaman sedang dalam tahap pengembangan:'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/navigation-bar',
                                  (route) => false,
                            );
                          },
                          child: const Text('Kembali ke Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
