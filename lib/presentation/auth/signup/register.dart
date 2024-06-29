import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:doctor_plus/domain/cubits/auth/signup_cubit.dart';
import 'package:doctor_plus/presentation/auth/widgets/auth.switch_page.dart';
import 'package:doctor_plus/presentation/auth/widgets/signin_option.dart';
import 'package:doctor_plus/presentation/auth/widgets/terms_conditions.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/validator.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/check_box.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
                      // navigate(route: Routes.registerFill);
                      if (_formKey.currentState?.validate() == true) {
                        createNewUser();
                        navigate(route: Routes.registerFill);
                      }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  buildSubmitButton(
                    widthFactor: .5,
                    label: "Add Doctor Demo Data",
                    onPressed: () async {
                      await addDoctors();
                      SuccessToast.showToast(
                        msg: "Doctors Demo Data Added Successfully",
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  buildSubmitButton(
                    widthFactor: .7,
                    label: "Add Patient Demo Data",
                    onPressed: () async {
                      await addPatients();
                      SuccessToast.showToast(
                        msg: "Patients Demo Data Added Successfully",
                      );
                    },
                  ),
                  signInOptions(),
                  Center(child: termsAndConditions()),
                  const SwitchAuthPage(
                    link: "Login",
                    route: Routes.login,
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

  Future<void> addDoctors() async {
    for (var doctor in demoDoctorData) {
      print("\n\nAdding - ==========================");
      print("Adding - ${doctor.email}");
      var user = await CustomFirebase().createAccountWithEmailAndPassword(
        email: doctor.email,
        password: "123456",
      );
      print("Adding - $user");

      context
          .read<SignupCubit>()
          .saveDemoDoctorAdditionalData(data: doctor, id: user);
      print("Adding - Data Added Successfully");

      print("Adding - ==========================\n\n");
    }
  }

  Future<void> addPatients() async {
    for (var patient in demoPatientData) {
      print("\n\nAdding - ==========================");
      print("Adding - ${patient.email}");
      var user = await CustomFirebase().createAccountWithEmailAndPassword(
        email: patient.email,
        password: "123456",
      );
      print("Adding - $user");

      context
          .read<SignupCubit>()
          .saveDemoPatientAdditionalData(data: patient, id: user);
      print("Adding - Data Added Successfully");

      print("Adding - ==========================\n\n");
    }
  }

  void navigate({required String route}) =>
      Navigator.pushReplacementNamed(context, route);

  void showErrorDialog({required String error}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(error),
          ));

  void createNewUser() async {
    try {
      var user =
          await CustomFirebase.instance.createAccountWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await SharedPreference().setString(key: 'userID', value: user);
    } catch (e) {
      // print(e);
      showErrorDialog(error: Validator.firebaseRegisterValidator(e.toString()));
    }
  }
}
