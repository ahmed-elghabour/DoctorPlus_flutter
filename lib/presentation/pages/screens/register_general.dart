import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:doctor_plus/presentation/widgets/inputs.dart';
import 'package:doctor_plus/presentation/widgets/drop_down.dart';
import 'package:doctor_plus/presentation/widgets/date_picker.dart';
import 'package:doctor_plus/presentation/widgets/image_picker.dart';

class RegisterGeneral extends StatefulWidget {
  const RegisterGeneral({super.key});

  @override
  State<RegisterGeneral> createState() => _RegisterGeneralState();
}

class _RegisterGeneralState extends State<RegisterGeneral> {
  String gender = "Male";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CustomImagePicker(),
              const SizedBox(height: 16.0),
              buildTextField(
                controller: _fNameController,
                label: 'First Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 16.0),
              buildTextField(
                controller: _lNameController,
                label: 'Last Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CustomDropDownMenu(
                      value: gender,
                      list: const ['Male', 'Female'],
                      onChanged: (String? newVal) =>
                          setState(() => gender = newVal!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    flex: 3,
                    child: CustomDatePicker(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
