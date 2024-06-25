import 'package:doctor_plus/presentation/doctor%20home/utils/random_colors.dart';
import 'package:doctor_plus/presentation/doctor%20home/widgets/patient_card.dart';
import 'package:flutter/material.dart';

List<Widget> getSliders(List<List<dynamic>>chunkedReservations) {
  List<Widget> reservationSliders = chunkedReservations.map((chunk) {
    return Column(
      children: chunk.map((item) {
        print(item['patientId']);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: PatientCard(patientId: item['patientName'], reservationType: item['appointmentType'], reservationDate: item['appointmentDateTime'], color: getRandomColor(),)
        );
      }).toList(),
    );
  }).toList();

  return reservationSliders;
}