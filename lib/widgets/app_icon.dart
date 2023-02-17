import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.09),
            spreadRadius: 15,
            blurRadius: 20,
          )
        ],
        borderRadius: BorderRadius.circular(90),
      ),
      child: const Icon(Icons.ac_unit_rounded, size: 50),
    );
  }
}
