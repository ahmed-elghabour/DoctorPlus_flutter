import 'package:flutter/material.dart';

Widget customCheckBox({
  required bool value,
  required String label,
  required void Function(bool?)? onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(
        value: value,
        splashRadius: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: onChanged,
      ),
      Text(label),
    ],
  );
}
