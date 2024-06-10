import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/presentation/widgets/inputs/text_input.dart';
import 'package:doctor_plus/presentation/widgets/auth.options.dart';
import 'package:doctor_plus/presentation/widgets/buttons/button.dart';
import 'package:doctor_plus/presentation/widgets/auth.switch_page.dart';

import '../widgets/inputs/password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  loginInputs(
                    email: _emailController,
                    password: _passwordController,
                  ),
                  buildSubmitButton(
                    label: "Login",
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        loginUser();
                      }
                    },
                  ),
                  const SwitchAuthPage(
                    link: "Create new",
                    route: Routes.register,
                    label: "Don`t have an account?",
                  ),
                  const SizedBox(height: 16.0),
                  const ExternalSignOptions()
                ],
              ),
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
  void loginUser() async {
    try {
      await CustomFirebase.instance.signWithCredentials(
          user: Patient.login(
              email: _emailController.text,
              password: _passwordController.text));
      navigate(route: Routes.home);
    } catch (e) {
      showErrorDialog(error: e.toString());
    }
  }
}



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
