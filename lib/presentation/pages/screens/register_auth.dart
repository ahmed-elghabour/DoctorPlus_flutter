import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/widgets/check_box.dart';
import 'package:doctor_plus/presentation/widgets/image_picker.dart';

class RegisterAuth extends StatefulWidget {
  const RegisterAuth({super.key});

  @override
  State<RegisterAuth> createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CustomImagePicker(),
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
            children: <Widget>[
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
          FractionallySizedBox(
            widthFactor: .5,
            child: buildSubmitButton(
              label: "Register",
              onPressed: () {
                // if (_formKey.currentState?.validate() == true) {
                //   createNewUser();
                // }
              },
            ),
          ),
        ],
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
