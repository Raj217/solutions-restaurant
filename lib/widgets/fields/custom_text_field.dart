import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool editOnTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData? icon;
  final bool readOnlyMode;
  final String? initValue;
  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.editOnTap = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.readOnlyMode = false,
    this.icon,
    this.initValue,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEditing = false;
  bool readOnlyMode = false;
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    readOnlyMode =
        (widget.readOnlyMode == true) ? true : (widget.editOnTap && !isEditing);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 50,
          child: TextFormField(
            initialValue: widget.initValue,
            focusNode: focusNode,
            obscureText: widget.obscureText,
            readOnly: readOnlyMode,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            controller: widget.controller,
            onFieldSubmitted: (String q) {
              setState(() {
                isEditing = false;
              });
            },
            decoration: InputDecoration(
              border: readOnlyMode
                  ? const UnderlineInputBorder(borderSide: BorderSide.none)
                  : const UnderlineInputBorder(),
              prefixIcon: Icon(widget.icon, size: 20, color: accentColor),
              suffixIcon: widget.editOnTap
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          focusNode.requestFocus();
                          isEditing = true;
                        });
                      },
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: isEditing
                            ? const SizedBox()
                            : const Icon(Icons.edit,
                                size: 15, color: Colors.grey),
                      ),
                    )
                  : null,
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
