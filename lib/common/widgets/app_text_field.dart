import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintMsg;
  final TextEditingController textController;

  const AppTextField({
    super.key,
    required this.hintMsg,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: const TextStyle(color: Color(0xFF4F4F4F)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 8,
          top: 5,
        ),
        filled: true,
        fillColor: const Color(0xFFCCC2FE),
        border: const OutlineInputBorder(),
        hintText: hintMsg,
        hintStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
          color: Color(0xFF4F4F4F),
        ),
      ),
    );
  }
}
