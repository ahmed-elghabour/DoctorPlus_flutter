import 'package:doctor_plus/screen/widget/class/auth.options.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/model/patient.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/screen/widget/function/button/button.dart';
import 'package:doctor_plus/screen/page/auth/login/input.form.dart';
import 'package:doctor_plus/screen/widget/class/auth.switch_page.dart';

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
