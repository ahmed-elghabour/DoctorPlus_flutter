import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/widgets/check_box.dart';
import 'package:doctor_plus/presentation/widgets/signin_option.dart';
import 'package:doctor_plus/presentation/widgets/terms_conditions.dart';
import 'package:doctor_plus/presentation/widgets/auth.switch_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showBoth = false;
  bool showPassword = false;
  bool showRePassword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 30,
                        height: 2,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                    style: TextStyle(
                        fontSize: 18, height: 1.8, color: Colors.black54),
                  ),
                  buildEmailField(
                    controller: _emailController,
                    validator: (Validator.emailValidator),
                  ),
                  const SizedBox(height: 16.0),
                  buildNumberField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_android,
                      validator: (Validator.emailValidator)),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: buildPasswordField(
                          label: 'Password',
                          showPassword: showBoth ? true : showPassword,
                          controller: _passwordController,
                          validator: (Validator.passwordValidator),
                          changePasswordVisibility: () => setState(() {
                            showPassword = !showPassword;
                            if (showBoth) {
                              showRePassword = showBoth = false;
                            }
                          }),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildPasswordField(
                          label: 'Re-Password',
                          showPassword: showBoth ? true : showRePassword,
                          controller: _rePasswordController,
                          validator: (value) => Validator.rePasswordValidator(
                              value, _passwordController.text),
                          changePasswordVisibility: () => setState(() {
                            showRePassword = !showRePassword;
                            if (showBoth) {
                              showPassword = showBoth = false;
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  customCheckBox(
                    value: showBoth,
                    label: "Show Password",
                    onChanged: (val) => setState(() {
                      showBoth = val ??= false;
                      if (!showBoth) {
                        showPassword = showRePassword = false;
                      }
                    }),
                  ),
                  const SizedBox(height: 8.0),
                  buildSubmitButton(
                    widthFactor: .5,
                    label: "Create Account",
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.registerFill);
                      // if (_formKey.currentState?.validate() == true) {
                      //   createNewUser();
                      // }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  signInOptions(),
                  Center(child: termsAndConditions()),
                  const SwitchAuthPage(
                    link: "Login",
                    route: Routes.login,
                    label: "Already have an account?",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void navigate({required String route}) => Navigator.pushNamed(context, route);

  // void showErrorDialog({required String error}) => showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //           title: Text(error),
  //         ));

  // void createNewUser() async {
  //   try {
  //     await CustomFirebase.instance.createAccountWithCredentials(
  //       user: Patient.register(
  //           fName: _fNameController.text,
  //           lName: _lNameController.text,
  //           email: _emailController.text,
  //           password: _passwordController.text),
  //     );
  //     navigate(route: Routes.login);
  //   } catch (e) {
  //     showErrorDialog(error: e.toString());
  //   }
  // }
}
