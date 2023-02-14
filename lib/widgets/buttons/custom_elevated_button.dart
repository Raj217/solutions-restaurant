import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onTap;
  final Widget? leading;
  final String title;
  final Color? backgroundColor;
  const CustomElevatedButton(
      {Key? key,
      required this.onTap,
      this.leading,
      required this.title,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: BoxDecoration(
            color: backgroundColor ?? accentColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) leading!,
              SizedBox(width: leading == null ? 0 : 15),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
