import 'package:doctor_plus/data/model/doctor_reservation.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/random_colors.dart';
import 'package:doctor_plus/presentation/doctor%20home/widgets/patient_card.dart';
import 'package:flutter/material.dart';

List<Widget> getSliders(List<List<DoctorReservation>>chunkedReservations) {
  List<Widget> reservationSliders = chunkedReservations.map((chunk) {
    return Column(
      children: chunk.map((item) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: PatientCard(patientId: item.patientId, reservationType: item.reservationType, reservationDate: item.reservationDate, color: getRandomColor(),)
        );
      }).toList(),
    );
  }).toList();

  return reservationSliders;
}