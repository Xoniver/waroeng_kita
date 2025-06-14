import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarouselWidget extends StatelessWidget {
  const HomeCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/banner1.jpg',
      'assets/images/banner2.jpg',
      'assets/images/banner3.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
        ),
        items: imagePaths.map((imagePath) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
      ),
    );
  }
}
