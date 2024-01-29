import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String text;
  const InfoText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3C1F7B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.0),
      ),
    );
  }
}
