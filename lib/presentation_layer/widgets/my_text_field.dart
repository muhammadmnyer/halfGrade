import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final IconData prefix;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const MyTextField({
    super.key,
    required this.hint,
    required this.prefix,
    required this.controller,
    required this.validator,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
        fillColor: Colors.black.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(prefix),
      ),
      obscureText: obscureText,
    );
  }
}
