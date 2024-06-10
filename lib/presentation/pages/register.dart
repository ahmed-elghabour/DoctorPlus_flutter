import 'package:doctor_plus/presentation/widgets/auth.options.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/presentation/widgets/buttons/button.dart';
import 'package:doctor_plus/presentation/widgets/auth.switch_page.dart';

import '../../utils/input.validator.dart';
import '../widgets/inputs/password_input.dart';
import '../widgets/inputs/text_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                registerInputs(
                    fName: _fNameController,
                    lName: _lNameController,
                    email: _emailController,
                    password: _passwordController,
                    rePassword: _rePasswordController),
                buildSubmitButton(
                  label: "Register",
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      createNewUser();
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                const SwitchAuthPage(
                  link: "Login",
                  route: Routes.login,
                  label: "Already have an account?",
                ),
                const ExternalSignOptions()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigate({required String route}) => Navigator.pushNamed(context, route);

  void showErrorDialog({required String error}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(error),
          ));

  void createNewUser() async {
    try {
      await CustomFirebase.instance.createAccountWithCredentials(
        user: Patient.register(
            fName: _fNameController.text,
            lName: _lNameController.text,
            email: _emailController.text,
            password: _passwordController.text),
      );
      navigate(route: Routes.login);
    } catch (e) {
      showErrorDialog(error: e.toString());
    }
  }
}

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
