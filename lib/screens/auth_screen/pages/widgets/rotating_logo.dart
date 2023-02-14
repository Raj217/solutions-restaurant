import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

class RotatingLogo extends StatefulWidget {
  final double logoSize;
  final double blurRadius;
  const RotatingLogo(
      {Key? key, required this.logoSize, required this.blurRadius})
      : super(key: key);

  @override
  State<RotatingLogo> createState() => _RotatingLogoState();
}

class _RotatingLogoState extends State<RotatingLogo> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: mediumAnimDuration,
      height: widget.logoSize,
      width: widget.logoSize,
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(widget.logoSize),
          boxShadow: [
            BoxShadow(
              blurRadius: widget.blurRadius,
              spreadRadius: widget.blurRadius,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            )
          ]),
      child: const Icon(
        Icons.ac_unit_outlined,
        size: logoSizeLarge,
      ),
    );
  }
}
