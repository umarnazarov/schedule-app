import 'package:flutter/material.dart';

BoxDecoration linearGradientDecoration() {
  return const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(191 * (3.14159 / 180)),
    stops: [0.0, 0.5205, 1.1241],
    colors: [
      Color(0xFF2A2A2E),
      Color(0xFF2B125A),
      Color(0xFF000000),
    ],
  ));
}
