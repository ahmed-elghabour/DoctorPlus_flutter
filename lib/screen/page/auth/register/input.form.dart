import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/screen/widget/function/input.dart';

Widget registerInputs({
  required TextEditingController fName,
  required TextEditingController lName,
  required TextEditingController email,
  required TextEditingController password,
  required TextEditingController rePassword,
}) {
  return Column(
    children: [
      buildInputField(
        controller: fName,
        label: 'First Name',
        validator: (Validator.nameValidator),
      ),
      buildInputField(
        controller: lName,
        label: 'Last Name',
        validator: (Validator.nameValidator),
      ),
      const SizedBox(height: 16.0),
      buildInputField(
          controller: email,
          label: 'Email',
          validator: (Validator.emailValidator)),
      const SizedBox(height: 16.0),
      buildPasswordField(
          controller: password,
          label: 'Password',
          validator: (Validator.passwordValidator)),
      const SizedBox(height: 16.0),
      buildPasswordField(
        controller: rePassword,
        label: 'Confirm Password',
        validator: (value) => Validator.rePasswordValidator(
          value,
          password.text,
        ),
      ),
      const SizedBox(height: 32.0),
    ],
  );
}
