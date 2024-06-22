import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorReservation{
  final String doctorId;
  final String patientId;
  final String paymentMethod;
  final DateTime reservationDate;
  final String reservationType;

  DoctorReservation({
    required this.doctorId,
    required this.patientId,
    required this.paymentMethod,
    required this.reservationDate,
    required this.reservationType
  });

  factory DoctorReservation.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return DoctorReservation(
      doctorId: data['doctorId'],
      patientId: data['patientId'],
      paymentMethod: data['paymentMethod'],
      reservationDate: (data['reservationDate'] as Timestamp).toDate(),
      reservationType: data['reservationType'],
    );
  }

}