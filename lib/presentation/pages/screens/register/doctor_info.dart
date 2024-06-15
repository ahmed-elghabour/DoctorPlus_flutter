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
  String specialty = 'Select Choice';
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
            value: specialty,
            title: "Specialty",
            list: doctorSpecialties,
            onChanged: (newVal) => setState(() => specialty = newVal!)),
      ],
    );
  }
}
