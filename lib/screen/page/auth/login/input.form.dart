import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/screen/widget/function/input.dart';

Widget loginInputs({
  required TextEditingController email,
  required TextEditingController password,
}) {
  return Column(
    children: [
      const SizedBox(height: 16.0),
      buildInputField(
        controller: email,
        label: 'Email',
        validator: (Validator.emailValidator),
      ),
      const SizedBox(height: 16.0),
      buildPasswordField(
          controller: password,
          label: 'Password',
          validator: (Validator.passwordValidator)),
      const SizedBox(height: 32.0),
    ],
  );
}
