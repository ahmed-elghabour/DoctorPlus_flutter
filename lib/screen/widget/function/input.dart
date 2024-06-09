import 'package:flutter/material.dart';

Widget buildInputField(
    {required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text}) {
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

Widget buildPasswordField({
  required TextEditingController controller,
  required String label,
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
