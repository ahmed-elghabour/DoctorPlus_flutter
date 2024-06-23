import 'package:flutter/material.dart';

Widget customDatePicker({
  required String label,
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
        icon: const Icon(
          Icons.calendar_today,
          size: 15,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
