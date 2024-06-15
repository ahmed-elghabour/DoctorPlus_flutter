import 'package:flutter/material.dart';

Widget buildEmailField({
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: "Email Address",
      prefixIcon: const Icon(Icons.email),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Widget buildNumberField({
  required String label,
  required IconData icon,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Widget buildPasswordField({
  bool showPassword = false,
  required String label,
  required void Function()? changePasswordVisibility,
  required TextEditingController controller,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    obscureText: !showPassword,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      // prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        onPressed: changePasswordVisibility,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Widget buildTextField({
  required String label,
  IconData icon = Icons.person,
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
      prefixIcon: Icon(
        icon,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
