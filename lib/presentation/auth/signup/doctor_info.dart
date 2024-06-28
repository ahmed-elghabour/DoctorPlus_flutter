import 'dart:io';
import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/files_uploaded.dart';
import 'package:doctor_plus/core/widgets/inputs.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/doctor_working_.dart';
import 'package:doctor_plus/domain/cubits/auth/signup_cubit.dart';
import 'package:doctor_plus/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:doctor_plus/core/widgets/icon_picker.dart';
import 'package:doctor_plus/core/widgets/popup_dialog.dart';
import 'package:doctor_plus/presentation/auth/widgets/additional_info.dart';

class DoctorAdditionalInfo extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  const DoctorAdditionalInfo({
    super.key,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  State<DoctorAdditionalInfo> createState() => _DoctorAdditionalInfoState();
}

class _DoctorAdditionalInfoState extends State<DoctorAdditionalInfo> {
  List<String> dayes = [];
  List<File> _pdfFiles = [];
  List<String> degreesList = [];
  String day = 'Select Day';
  String degree = 'Select Choice';
  String specialty = 'Select Choice';
  String university = 'Select Choice';
  late TextEditingController _endController;
  late TextEditingController _feesController;
  late TextEditingController _dateController;
  late TextEditingController _startController;
  late TextEditingController _patientsController;
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _feesController = TextEditingController();
    _dateController = TextEditingController();
    _startController = TextEditingController();
    _endController = TextEditingController();
    _patientsController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
    _feesController.text = '200';
    _patientsController.text = '5';
    _startController.text = '12';
    _endController.text = '4';
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyCustomAppBar(
        title: "Doctor Additional Info",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 1, child: Text('Graduation Year')),
                          Expanded(
                            flex: 2,
                            child: customIconPicker(
                              label: 'Select Graduation Year',
                              icon: Icons.calendar_month,
                              controller: _dateController,
                              validator: (Validator.nameValidator),
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  helpText: "Select Graduation Year",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _dateController.text =
                                        DateFormat('yyyy-MM-dd').format(picked);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      additionalInfo(
                        value: university,
                        title: "University",
                        list: universities,
                        onChanged: (newVal) =>
                            setState(() => university = newVal!),
                      ),
                      additionalInfo(
                        value: specialty,
                        title: "Specialty",
                        list: doctorSpecialties,
                        onChanged: (newVal) =>
                            setState(() => specialty = newVal!),
                      ),
                      customAdditionaInfo(
                        value: degree,
                        title: "Degree",
                        list: doctorDgrees,
                        selectedlist: degreesList,
                        onRemove: (val) =>
                            setState(() => degreesList.remove(val)),
                        onChanged: (newVal) => setState(
                          () {
                            degree = newVal!;
                            degreesList.add(newVal);
                          },
                        ),
                      ),
                      customAdditionaInfo(
                        value: day,
                        title: "Working Days",
                        list: [
                          "Select Day",
                          "Sunday",
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                          "Friday",
                          "Saturday"
                        ],
                        selectedlist: dayes,
                        onRemove: (val) => setState(() => dayes.remove(val)),
                        onChanged: (newVal) => setState(
                          () => dayes.add(newVal!),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: buildNumberField(
                                label: "Fees",
                                isCenter: true,
                                icon: Icons.attach_money_outlined,
                                controller: _feesController,
                                validator: (Validator.generalValidator),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 8,
                              child: buildNumberField(
                                isCenter: true,
                                label: "Patients per day",
                                icon: Icons.groups_2_rounded,
                                controller: _patientsController,
                                validator: (Validator.generalValidator),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: buildNumberField(
                                label: "Start Time",
                                isCenter: true,
                                icon: Icons.av_timer_rounded,
                                controller: _startController,
                                validator: (Validator.generalValidator),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 8,
                              child: buildNumberField(
                                isCenter: true,
                                label: "End Time",
                                icon: Icons.timer_off,
                                controller: _endController,
                                validator: (Validator.generalValidator),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      buildMultiLineTextField(
                        hint:
                            "Write a brief description of your professional history",
                        label: "About Me",
                        validator: (Validator.descriptionValidator),
                        controller: _descriptionController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              const Text("* Upload"),
                              const SizedBox(height: 3),
                              _buildHintText(
                                  label:
                                      "This Field will be reviewed by the admin"),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              buildCustomDialog(
                                widgets: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _buildHintText(
                                          label:
                                              "* Required Documents (merge all files into one)"),
                                    ),
                                  ),
                                  _buildNormalText(label: "Syndicate ID"),
                                  _buildNormalText(label: "Practicing License"),
                                  _buildNormalText(
                                      label: "Internship Certificate"),
                                  _buildNormalText(
                                      label: "Graduation Certificate"),
                                  degreesList.isNotEmpty
                                      ? _buildNormalText(
                                          label: "Required Degree Certificates")
                                      : const SizedBox(),
                                ],
                                okText: "Upload",
                                context: context,
                                onOkPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                    allowMultiple: true,
                                  );

                                  if (result != null) {
                                    setState(() {
                                      _pdfFiles = result.paths
                                          .map((path) => File(path!))
                                          .toList();
                                    });
                                  }
                                },
                              );
                            },
                            icon: const Icon(
                              size: 34,
                              Icons.document_scanner_outlined,
                            ),
                          ),
                        ],
                      ),
                      fileUploaded(
                        files: _pdfFiles,
                        onCLear: () => setState(() => _pdfFiles = []),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildSubmitButton(
              widthFactor: .7,
              label: "Previous",
              onPressed: widget.onPrevious,
            ),
          ),
          const SizedBox(width: 10), // Spacer between buttons
          Expanded(
            child: buildSubmitButton(
              widthFactor: .7,
              label: "Submit",
              onPressed: () {
                context.read<SignupCubit>().saveDoctorAdditionalData(
                      data: Doctor.additional(
                        fees: int.parse(_feesController.text),
                        patients: int.parse(_patientsController.text),
                        workingDays: DoctorWorkingHours(
                          days: dayes,
                          startTimes: _startController.text,
                          endTimes: _endController.text,
                        ),
                        files: _pdfFiles,
                        specialty: specialty,
                        degrees: degreesList,
                        university: university,
                        description: _descriptionController.text,
                        graduationDate: _dateController.text,
                      ),
                    );
                widget.onSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Text _buildHintText({required String label}) {
  return Text(
    label,
    style: const TextStyle(
        color: Colors.redAccent,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold),
  );
}

Text _buildNormalText({required String label}) {
  return Text(
    label,
    style: const TextStyle(
      fontStyle: FontStyle.italic,
    ),
  );
}
