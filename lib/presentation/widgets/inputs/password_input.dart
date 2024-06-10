import 'package:flutter/material.dart';

Widget buildPasswordField({
  required String label,
  required TextEditingController controller,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    obscureText: true,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}
