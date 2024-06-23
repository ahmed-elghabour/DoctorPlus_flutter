import 'package:flutter/material.dart';
import '../widgets/signin_option.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/widgets/check_box.dart';
import 'package:doctor_plus/presentation/widgets/terms_conditions.dart';
import 'package:doctor_plus/presentation/widgets/auth_switch_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                  style: TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.black54),
                ),
                const LoginInputs(),
                signInOptions(),
                Center(child: termsAndConditions()),
                const SwitchAuthPage(
                  link: "Create new",
                  route: Routes.register,
                  label: "Don`t have an account?",
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginInputs extends StatefulWidget {
  const LoginInputs({super.key});
  @override
  State<LoginInputs> createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  bool rememberMe = false;
  bool showPassword = false;
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16.0),
          buildEmailField(
            controller: _emailController,
            validator: (Validator.emailValidator),
          ),
          const SizedBox(height: 16.0),
          buildPasswordField(
              label: 'Password',
              showPassword: showPassword,
              controller: _passwordController,
              validator: (Validator.passwordValidator),
              changePasswordVisibility: () =>
                  setState(() => showPassword = !showPassword)),
          const SizedBox(height: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customCheckBox(
                value: rememberMe,
                label: "Remember me",
                onChanged: (val) => setState(() => rememberMe = val ??= false),
              ),
              buildTextButton(
                label: "Forgot Password?",
                onPressed: () {},
              ),
            ],
          ),
          buildSubmitButton(
            label: "Login",
            widthFactor: .5,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                loginUser();
              }
            },
          ),
        ],
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
