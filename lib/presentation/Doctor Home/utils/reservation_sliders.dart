import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/patient_card.dart';
import 'package:doctor_plus/presentation/Profile%20Preview/pages/profile_preview.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/random_colors.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

List<Widget> getSliders(List<List<dynamic>> chunkedReservations,
    List<Patient> patients, BuildContext context) {
  List<Widget> reservationSliders = chunkedReservations.map((chunk) {
    return Column(
      children: chunk.map((item) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientPreview(
                      appointment: item,
                      patient:
                          patients.firstWhere((p) => p.id == item.patientId),
                    )),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: PatientCard(
              patient: patients.firstWhere((p) => p.id == item.patientId),
              type: item.type,
              date: item.date,
              color: getRandomColor(),
            ),
          ),
        );
      }).toList(),
    );
  }).toList();

  return reservationSliders;
}
