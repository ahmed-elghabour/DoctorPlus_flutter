import 'package:doctor_plus/presentation/widgets/auth.switch_page.dart';
import 'package:doctor_plus/presentation/widgets/signin_option.dart';
import 'package:doctor_plus/presentation/widgets/terms_conditions.dart';
import 'package:flutter/material.dart';
import '../../utils/input_validator.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/widgets/check_box.dart';
import 'package:doctor_plus/presentation/widgets/image_picker.dart';

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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildEmailField(
                    controller: _emailController,
                    validator: (Validator.emailValidator),
                  ),
                  const SizedBox(height: 16.0),
                  buildPasswordField(
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
                  const SizedBox(height: 16.0),
                  buildPasswordField(
                    label: 'Confirm Password',
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
                    label: "Register",
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.registerFill);
                      // if (_formKey.currentState?.validate() == true) {
                      //   createNewUser();
                      // }
                    },
                  ),
                  signInOptions(),
                  Center(child: termsAndConditions()),
                  const SwitchAuthPage(
                    link: "Login",
                    route: Routes.register,
                    label: "Already have an account?",
                  ),
                  const SizedBox(height: 16.0),
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
