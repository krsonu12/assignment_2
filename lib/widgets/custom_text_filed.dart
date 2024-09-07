import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final Widget? widget;

  final TextInputType? keyboardType;
  final int? maxLines = 1;
  final String? Function(String?) validator;
  const CustomTextFiled({
    this.widget,
    super.key,
    this.label,
    this.hintText,
    required this.controller,
    this.keyboardType,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: validator,
    );
  }
}
