import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255, // Alpha (opacity) value (255 means fully opaque)
    random.nextInt(256), // Red value (0-255)
    random.nextInt(256), // Green value (0-255)
    random.nextInt(256), // Blue value (0-255)
  );
}