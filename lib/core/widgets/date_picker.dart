import 'package:flutter/material.dart';

Widget customDatePicker({
  double iconSize = 20,
  required String label,
  required IconData icon,
  required void Function()? onPressed,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      suffixIcon: IconButton(
        icon: Icon(
          icon,
          size: iconSize,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
