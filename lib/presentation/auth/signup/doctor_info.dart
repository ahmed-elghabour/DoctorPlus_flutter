import 'dart:io';
import 'package:doctor_plus/core/widgets/files_uploaded.dart';
import 'package:doctor_plus/utils/input.validator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:doctor_plus/core/widgets/icon_picker.dart';
import 'package:doctor_plus/core/widgets/popup_dialog.dart';
import 'package:doctor_plus/presentation/auth/widgets/additional_info.dart';

class DoctorAdditionalInfo extends StatefulWidget {
  const DoctorAdditionalInfo({super.key});

  @override
  State<DoctorAdditionalInfo> createState() => _DoctorAdditionalInfoState();
}

class _DoctorAdditionalInfoState extends State<DoctorAdditionalInfo> {
  List<File> _pdfFiles = [];
  List<String> degreesList = [];
  String degree = 'Select Choice';
  String specialty = 'Select Choice';
  String university = 'Select Choice';
  late TextEditingController _dateController;
  @override
  void initState() {
    _dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            const Expanded(flex: 1, child: Text('Graduation Year')),
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
                )),
          ],
        ),
        additionalInfo(
            value: university,
            title: "University",
            list: universities,
            onChanged: (newVal) => setState(() => university = newVal!)),
        additionalInfo(
            value: specialty,
            title: "Specialty",
            list: doctorSpecialties,
            onChanged: (newVal) => setState(() => specialty = newVal!)),
        customAdditionaInfo(
            value: degree,
            title: "Degree",
            list: doctorDgrees,
            selectedlist: degreesList,
            onRemove: (val) => setState(() => degreesList.remove(val)),
            onChanged: (newVal) => setState(() {
                  degree = newVal!;
                  degreesList.add(newVal);
                })),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Wrap(
              direction: Axis.vertical,
              children: [
                const Text("* Upload"),
                const SizedBox(height: 3),
                _buildHintText(
                    label: "This Field will be reviewed by the admin"),
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
                    _buildNormalText(label: "Internship Certificate"),
                    _buildNormalText(label: "Graduation Certificate"),
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
                        _pdfFiles =
                            result.paths.map((path) => File(path!)).toList();
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
