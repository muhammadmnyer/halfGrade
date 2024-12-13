import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarouselSlider extends StatelessWidget {
  final List<Widget> items;
  const MyCarouselSlider({super.key,required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
            viewportFraction: 0.7,
            height: 300,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            autoPlayInterval: const Duration(seconds: 6),
            enlargeFactor: 0.3,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale

        )
    );
  }
}
