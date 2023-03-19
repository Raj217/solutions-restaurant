import 'package:flutter/material.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Widget? label;
  final Size? minSize;
  const CustomElevatedIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.label,
      this.minSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          minimumSize: minSize ?? const Size(double.infinity, 56),
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        icon: icon,
        label: label ?? const SizedBox.shrink());
  }
}
