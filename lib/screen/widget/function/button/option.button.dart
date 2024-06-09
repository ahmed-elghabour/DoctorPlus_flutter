import 'package:flutter/material.dart';

Widget buildOptionButton(
    {required void Function()? onTap, required String src}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/$src.png'),
      ),
    ),
  );
}
