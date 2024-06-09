import 'package:flutter/material.dart';

Widget buildSubmitButton(
    {required void Function()? onPressed, required String label}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(label),
  );
}
