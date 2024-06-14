import 'package:doctor_plus/presentation/pages/screens/doctor_info.dart';
import 'package:doctor_plus/presentation/pages/screens/patient_info.dart';
import 'package:doctor_plus/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';

enum TYPE { patient, doctor }

class RegisterAdditional extends StatefulWidget {
  const RegisterAdditional({super.key});

  @override
  State<RegisterAdditional> createState() => _RegisterAdditionalState();
}

class _RegisterAdditionalState extends State<RegisterAdditional> {
  // final _formKey = GlobalKey<FormState>();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTextButton(
                onPressed: () => setState(() => index = 0), label: "Patient"),
            buildTextButton(
                onPressed: () => setState(() => index = 1), label: "Doctor"),
          ],
        ),
        Expanded(child: buildSwiperWidget(index)),
      ],
    );
  }
}

Widget buildSwiperWidget(int index) {
  switch (index) {
    case 0:
      return const PatientAdditionalInfo();
    case 1:
      return const DoctorAdditionalInfo();
    default:
      return const PatientAdditionalInfo();
  }
}
