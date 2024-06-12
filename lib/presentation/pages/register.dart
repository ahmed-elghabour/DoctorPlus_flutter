import 'package:doctor_plus/presentation/pages/screens/register_additional.dart';
import 'package:doctor_plus/presentation/pages/screens/register_auth.dart';
import 'package:doctor_plus/presentation/pages/screens/register_general.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:doctor_plus/presentation/widgets/check_box.dart';
import 'package:doctor_plus/presentation/widgets/date_picker.dart';
import 'package:doctor_plus/presentation/widgets/drop_downs.dart';
import 'package:doctor_plus/presentation/widgets/image_picker.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/presentation/widgets/auth.switch_page.dart';

import '../../utils/input.validator.dart';
import '../widgets/signin_option.dart';
import '../widgets/terms_conditions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int index = 0;
  final PageController _pageController = PageController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                style1(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget style2() {
  PageController pageController = PageController();
  return Column(
    children: [
      PageView(
        controller: pageController,
        children: const [
          RegisterGeneral(),
          RegisterAdditional(),
          RegisterAuth(),
        ],
      ),
      const RegistrationInputs(),
      const SizedBox(height: 8.0),
      signInOptions(),
      Center(child: termsAndConditions()),
      const SwitchAuthPage(
        link: "Login",
        route: Routes.login,
        label: "Already have an account?",
      ),
    ],
  );
}

Widget style1() {
  return Column(
    children: [
      const RegistrationInputs(),
      const SizedBox(height: 8.0),
      signInOptions(),
      Center(child: termsAndConditions()),
      const SwitchAuthPage(
        link: "Login",
        route: Routes.login,
        label: "Already have an account?",
      ),
    ],
  );
}

class RegistrationInputs extends StatefulWidget {
  const RegistrationInputs({super.key});

  @override
  State<RegistrationInputs> createState() => _RegistrationInputsState();
}

class _RegistrationInputsState extends State<RegistrationInputs> {
  bool showBoth = false;
  String gender = "Male";
  bool showPassword = false;
  bool showRePassword = false;
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CustomImagePicker(),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: buildTextField(
                  controller: _fNameController,
                  label: 'First Name',
                  validator: (Validator.nameValidator),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildTextField(
                  controller: _lNameController,
                  label: 'Last Name',
                  validator: (Validator.nameValidator),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          buildEmailField(
            controller: _emailController,
            validator: (Validator.emailValidator),
          ),
          const SizedBox(height: 16.0),
          buildNumberField(
              controller: _emailController,
              label: 'Phone Number',
              icon: Icons.phone_android,
              validator: (Validator.emailValidator)),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(
                child: genderDropDownMenu(
                  value: gender,
                  onChanged: (String? newVal) =>
                      setState(() => gender = newVal!),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(child: CustomDatePicker()),
            ],
          ),
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
                if (_formKey.currentState?.validate() == true) {
                  createNewUser();
                }
              },
            ),
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
