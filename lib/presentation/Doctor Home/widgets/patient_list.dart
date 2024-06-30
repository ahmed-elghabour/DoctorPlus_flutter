import 'package:doctor_plus/presentation/Doctor%20Home/widgets/patients_carousel.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  const PatientList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Patient List",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        PatientsCarousel()
      ],
    );
  }
}
