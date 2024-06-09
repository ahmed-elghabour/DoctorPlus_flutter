import 'package:flutter/material.dart';

Widget buildTextButton(
    {required void Function()? onPressed, required String label}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(label,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        )),
  );
}
