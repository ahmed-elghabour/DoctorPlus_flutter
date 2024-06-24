import 'package:flutter/material.dart';

Widget termsAndConditions() {
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(height: 1.5),
        children: [
          TextSpan(
            text: "By logging, you agree to our",
            style: _buildNormalText(),
          ),
          TextSpan(
            text: " Terms & Conditions",
            style: _buildBoldText(),
          ),
          TextSpan(
            text: " \nand ",
            style: _buildNormalText(),
          ),
          TextSpan(
            text: "Privacy Policy.",
            style: _buildBoldText(),
          ),
        ],
      ),
    ),
  );
}

TextStyle _buildNormalText() {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );
}

TextStyle _buildBoldText() {
  return const TextStyle(
    color: Colors.black87,
    fontSize: 17,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );
}
