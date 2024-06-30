import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:intl/intl.dart';

class DoctorService {
  static final CollectionReference reservations =
      FirebaseFirestore.instance.collection('appointments');

  static Stream<List<dynamic>>? getReservations(
      String doctorId, String datePicked) {
    DateTime pickedDate = DateFormat('yyyy-MM-dd').parse(datePicked);
    DateTime startOfDay =
        DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 0, 0, 0);
    DateTime endOfDay =
        DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 23, 59, 59);

    final reservationsStream = reservations
        .where('doctorId', isEqualTo: doctorId)
        .where('appointmentDateTime', isGreaterThanOrEqualTo: startOfDay)
        .where('appointmentDateTime', isLessThanOrEqualTo: endOfDay)
        .orderBy('appointmentDateTime', descending: false)
        .snapshots();

    return reservationsStream.map((QuerySnapshot query) {
      final List<Map<String, dynamic>> filteredAppointments =
          query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return filteredAppointments;
    });
  }

  static Stream<List<int>> getPatientsNumAtDay(String doctorId) {
    final reservationStream =
        reservations.where('doctorId', isEqualTo: doctorId).snapshots();
    return reservationStream.map((QuerySnapshot query) {
      int newCount = 0;
      int oldCount = 0;
      int todayCount = 0;
      DateTime now = DateTime.now();
      final List<Map<String, dynamic>> filteredAppointments =
          query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      for (var doc in filteredAppointments) {
        AppointmentModel reservation = AppointmentModel.fromJson(doc);
        DateFormat format = DateFormat("yyyy-MM-dd");
        DateTime reservationDate = format.parse(reservation.date);
        // print(reservationDate.toDate());
        if (reservationDate
            .isAfter(DateTime(now.year, now.month, now.day, 23, 59, 59))) {
          newCount++;
        } else if (reservationDate
            .isBefore(DateTime(now.year, now.month, now.day, 0, 0, 0))) {
          oldCount++;
        } else {
          todayCount++;
        }
      }
      return [newCount, oldCount, todayCount];
    });
  }
}
