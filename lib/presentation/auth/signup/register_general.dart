import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
import 'package:doctor_plus/core/widgets/drop_down.dart';
import 'package:doctor_plus/core/widgets/date_picker.dart';
import 'package:doctor_plus/core/widgets/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class RegisterGeneral extends StatefulWidget {
  final void Function()? onNext;
  const RegisterGeneral({super.key, required this.onNext});

  @override
  State<RegisterGeneral> createState() => _RegisterGeneralState();
}

class _RegisterGeneralState extends State<RegisterGeneral> {
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomImagePicker(),
              ),
              buildTextField(
                controller: _fNameController,
                label: 'First Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 8.0),
              buildTextField(
                controller: _lNameController,
                label: 'Last Name',
                validator: (Validator.nameValidator),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CustomDropDownMenu(
                      value: type,
                      list: const ["Patient", "Doctor"],
                      onChanged: (String? newVal) =>
                          setState(() => type = newVal!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 3,
                      child: customDatePicker(
                        label: 'Address Location',
                        icon: Icons.location_on,
                        controller: _locationController,
                        onPressed: () async {
                          bool serviceEnabled;
                          LocationPermission permission;
                          serviceEnabled =
                              await Geolocator.isLocationServiceEnabled();
                          if (!serviceEnabled) {
                            FailureToast.showToast(
                                msg: "Please enable Location Service");
                            return;
                          }
                          permission = await Geolocator.checkPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {
                              FailureToast.showToast(
                                  msg: "Please enable Location Permission");
                              return;
                            }
                          }

                          if (permission == LocationPermission.deniedForever) {
                            FailureToast.showToast(
                                msg: "Please open settings and enable Location Permission");
                            return;
                          }
                          final Position position =
                              await Geolocator.getCurrentPosition();
                          setState(() {
                            _locationController.text = position.toString();
                          });
                        },
                      )),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CustomDropDownMenu(
                      value: gender,
                      list: const ["Male", "Female"],
                      onChanged: (String? newVal) =>
                          setState(() => gender = newVal!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 3,
                      child: customDatePicker(
                        label: 'Birth Date',
                        icon: Icons.calendar_month,
                        controller: _birthDateController,
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
              const SizedBox(height: 8.0),
              buildSubmitButton(
                widthFactor: .7,
                label: "Next",
                onPressed: widget.onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
