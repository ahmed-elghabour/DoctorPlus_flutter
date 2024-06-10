import 'package:flutter/material.dart';

Widget buildInputField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?) validator,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}


