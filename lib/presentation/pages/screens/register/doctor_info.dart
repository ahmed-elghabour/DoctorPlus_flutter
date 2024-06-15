import 'package:doctor_plus/data/demo.dart';
import 'package:doctor_plus/presentation/widgets/additional_info.dart';
import 'package:doctor_plus/presentation/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorAdditionalInfo extends StatefulWidget {
  const DoctorAdditionalInfo({super.key});

  @override
  State<DoctorAdditionalInfo> createState() => _DoctorAdditionalInfoState();
}

class _DoctorAdditionalInfoState extends State<DoctorAdditionalInfo> {
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
                child: customDatePicker(
                  label: 'Select Graduation Year',
                  controller: _dateController,
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
            value: degree,
            title: "Degree",
            list: doctorDgrees,
            onChanged: (newVal) => setState(() => degree = newVal!)),
        additionalInfo(
            value: specialty,
            title: "Specialty",
            list: doctorSpecialties,
            onChanged: (newVal) => setState(() => specialty = newVal!)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Wrap(
              direction: Axis.vertical,
              children: [
                Text("* Upload"),
                SizedBox(height: 3),
                Text("This Field will be reviewed by the admin",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  size: 34,
                  Icons.document_scanner_outlined,
                )),
          ],
        )
      ],
    );
  }
}
