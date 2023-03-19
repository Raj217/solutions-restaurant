import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final IconData icon;
  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 15, color: accentColor),
              errorStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
