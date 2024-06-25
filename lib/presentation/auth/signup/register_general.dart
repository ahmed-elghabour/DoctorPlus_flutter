import 'dart:io';

import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
import 'package:doctor_plus/core/widgets/drop_down.dart';
import 'package:doctor_plus/core/widgets/icon_picker.dart';
import 'package:doctor_plus/core/widgets/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterGeneral extends StatefulWidget {
  final VoidCallback onNext;
  const RegisterGeneral({super.key, required this.onNext});

  @override
  State<RegisterGeneral> createState() => _RegisterGeneralState();
}

class _RegisterGeneralState extends State<RegisterGeneral> {
  File? image;
  String type = "Patient";
  String gender = "Male";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _locationController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomImagePicker(
                  image: image,
                  onFileSelected: () async => await _pickImage(),
                ),
              ),
              buildTextField(
                controller: _fNameController,
                label: 'First Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 15),
              buildTextField(
                controller: _lNameController,
                label: 'Last Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CustomDropDownMenu(
                      value: type,
                      label: "Select User Type",
                      list: const ["Patient", "Doctor"],
                      onChanged: (String? newVal) =>
                          setState(() => type = newVal!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 3,
                      child: customIconPicker(
                        icon: Icons.location_on,
                        label: 'Address Location',
                        controller: _locationController,
                        validator: (Validator.generalValidator),
                        onPressed: () async => accessLocation(),
                      )),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CustomDropDownMenu(
                      value: gender,
                      label: "Select Gender",
                      list: const ["Male", "Female"],
                      onChanged: (String? newVal) =>
                          setState(() => gender = newVal!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 3,
                      child: customIconPicker(
                        isCenter: true,
                        label: 'Birth Date',
                        icon: Icons.calendar_month,
                        controller: _birthDateController,
                        validator: (Validator.generalValidator),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            helpText: "Select Birth Date",
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _birthDateController.text =
                                  DateFormat('yyyy-MM-dd').format(picked);
                            });
                          }
                        },
                      )),
                ],
              ),
              const SizedBox(height: 15),
              buildSubmitButton(
                widthFactor: .7,
                label: "Next",
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    SuccessToast.showToast(msg: "Register Successful");
                    widget.onNext();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isInputsValid() {
    if (_fNameController.text.isEmpty ||
        _lNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _birthDateController.text.isEmpty) {
      return false;
    }

    if (_fNameController.text.isEmpty) {
      FailureToast.showToast(msg: "First Name");
      return false;
    }
    return true;
  }

  Future<void> accessLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      FailureToast.showToast(msg: "Please enable Location Service");
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        FailureToast.showToast(msg: "Please enable Location Permission");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      FailureToast.showToast(
          msg: "Please open settings and enable Location Permission");
      return;
    }
    final Position position = await Geolocator.getCurrentPosition();
    var res =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    GeneralToast.showToast(msg: res.toString());
    // print("\n\n Trace: ==============================================");
    // print("\nLatitude: ${position.latitude}");
    // print("\nLongitude: ${position.longitude}");
    // print("\nAddress: ${res.toString()}");
    // print("End-Trace: ==============================================\n\n ");
    setState(() {
      _locationController.clear();
      _locationController.text = position.toString();
    });
  }
}
