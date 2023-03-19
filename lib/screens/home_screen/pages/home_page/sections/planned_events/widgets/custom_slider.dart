import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 10,
      itemBuilder: (_, __, ___) {
        return SizedBox();
      },
      options: CarouselOptions(
        height: 100,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        enableInfiniteScroll: false,
        initialPage: 3,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
