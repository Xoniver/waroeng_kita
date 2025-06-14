import 'package:flutter/material.dart';
import '../models/product_model.dart';

class DaftarProdukController extends ChangeNotifier {
  final List<DaftarProduk> listdaftarProduk = [
    DaftarProduk(
      imagePath: 'assets/images/abonsapi.png',
      name: 'Abon Sapi',
      price: 'Rp 16.000',
      description: "Abon sapi adalah makanan kering yang terbuat dari daging sapi yang disuwir halus dan dimasak dengan bumbu rempah hingga kering dan gurih. Cocok dijadikan lauk pendamping nasi atau isian roti.",
      totalItem: 15,
    ),
    DaftarProduk(
      imagePath: 'assets/images/jenang.png',
      name: 'Jenang',
      price: 'Rp 25.000',
      description: "Jenang adalah makanan tradisional khas Indonesia berbahan dasar ketan dan santan yang dimasak hingga kental. Memiliki rasa manis dan tekstur lengket, cocok sebagai camilan atau oleh-oleh.",
      totalItem: 15,
    ),
    DaftarProduk(
      imagePath: 'assets/images/klanting.png',
      name: 'Klanting',
      price: 'Rp 12.000',
      description: "Klanting adalah jajanan tradisional berbahan dasar singkong dengan warna-warni menarik dan tekstur kenyal. Biasanya disajikan dengan parutan kelapa dan gula merah cair.",
      totalItem: 10,
    ),
    DaftarProduk(
      imagePath: 'assets/images/pisang.png',
      name: 'Keripik Pisang',
      price: 'Rp 20.000',
      description: "Keripik pisang adalah camilan renyah yang dibuat dari pisang matang yang diiris tipis dan digoreng kering. Memiliki rasa manis atau asin, cocok dinikmati kapan saja.",
      totalItem: 8,
    ),
    DaftarProduk(
      imagePath: 'assets/images/aqua_cup.jpg',
      name: 'Aqua Air Mineral Cup 48 x 200 ml - Karton',
      price: 'Rp 46.000',
      description: "Aqua air mineral dalam kemasan cup praktis isi 48 cup per karton. Ideal untuk kebutuhan acara, pertemuan, atau persediaan harian di rumah dan kantor.",
      totalItem: 5,
    ),
    DaftarProduk(
      imagePath: 'assets/images/bearbrand.jpg',
      name: 'Bear Brand Susu Steril 30 x 189 ml - Karton',
      price: 'Rp 258.000',
      description: "Bear Brand adalah susu steril siap minum yang diproses secara higienis tanpa bahan pengawet. Dikenal menyehatkan dan cocok untuk menjaga daya tahan tubuh.",
      totalItem: 20,
    ),
    DaftarProduk(
      imagePath: 'assets/images/popmiegoreng.jpg',
      name: 'Pop Mie Mi Instan Cup Goreng 12 x 43 g - Karton',
      price: 'Rp 24.000',
      description: "Pop Mie Goreng adalah mi instan dalam cup yang praktis dan cepat disajikan. Rasanya gurih dan lezat, cocok untuk camilan cepat atau bekal perjalanan.",
      totalItem: 10,
    ),
    DaftarProduk(
      imagePath: 'assets/images/cocacola.jpg',
      name: 'Coca-Cola Kaleng - Karton 24 x 250 ml',
      price: 'Rp 48.000',
      description: "Coca-Cola adalah minuman soda berkarbonasi dengan rasa khas kola. Dikemas dalam kaleng 250 ml, ideal untuk dinikmati dingin saat bersantai atau bersama teman.",
      totalItem: 10,
    ),
    DaftarProduk(
      imagePath: 'assets/images/gulagmp.jpg',
      name: 'GMP Gula Pasir Kristal Putih 1 kg',
      price: 'Rp 18.000',
      description: "Gula pasir GMP berkualitas tinggi, berwarna putih jernih dan cepat larut. Cocok untuk kebutuhan dapur sehari-hari, baik untuk masakan maupun minuman.",
      totalItem: 10,
    ),
    DaftarProduk(
      imagePath: 'assets/images/gulaku.jpg',
      name: 'Gulaku Gula Pasir Tebu Kuning 1 kg',
      price: 'Rp 18.000',
      description: "Gulaku tebu kuning adalah gula pasir alami dari tebu pilihan. Warna kuning keemasan menandakan proses minim pemurnian, cocok untuk minuman dan kue tradisional.",
      totalItem: 10,
    ),
    DaftarProduk(
      imagePath: 'assets/images/kopiko.jpg',
      name: 'Kopiko Blister Permen Bebas Gula 32 g',
      price: 'Rp 12.000',
      description: "Kopiko bebas gula adalah permen kopi yang nikmat dan menyegarkan tanpa tambahan gula. Cocok untuk kamu yang ingin menikmati rasa kopi tanpa khawatir kalori.",
      totalItem: 10,
    ),
  ];
}
