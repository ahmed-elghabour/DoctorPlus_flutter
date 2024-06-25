import 'package:flutter/material.dart';

Widget customIconPicker({
  double iconSize = 20,
  bool isCenter = false,
  required String label,
  required IconData icon,
  required void Function()? onPressed,
  required String? Function(String?) validator,
  required TextEditingController controller,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    // readOnly: true,
    textAlign: isCenter ? TextAlign.center : TextAlign.start,
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

