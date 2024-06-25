import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/doctor_reservation.dart';
import 'package:intl/intl.dart';

class DoctorService {
  static final CollectionReference reservations = FirebaseFirestore.instance.collection('reservations');

  static Stream<List<DoctorReservation>>? getReservations(String doctorId, String datePicked) {
    DateTime pickedDate = DateFormat('yyyy-MM-dd').parse(datePicked);
    DateTime startOfDay = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 0, 0, 0);
    DateTime endOfDay = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 23, 59, 59);

    final reservationsStream = reservations.where('doctorId', isEqualTo: doctorId)
    .where('reservationDate', isGreaterThanOrEqualTo: startOfDay)
    .where('reservationDate', isLessThanOrEqualTo: endOfDay)
    .orderBy('reservationDate', descending: false)
    .snapshots();
      
     return reservationsStream.map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return DoctorReservation.fromFireStore(doc);
      }).toList();
    });
  }
  
  static Stream<List<int>> getPatientsNumAtDay(String doctorId){
    final reservationStream = reservations.where('doctorId', isEqualTo: doctorId).snapshots();
    return reservationStream.map((QuerySnapshot query) {
      int newCount = 0;
      int oldCount = 0;
      int todayCount = 0;
      DateTime now = DateTime.now();
      for(var doc in query.docs) {
        DoctorReservation reservation = DoctorReservation.fromFireStore(doc);
        DateTime reservationDate = reservation.reservationDate;
        if (reservationDate.isAfter(DateTime(now.year, now.month, now.day, 23, 59, 59))) {
          newCount++;
        } else if (reservationDate.isBefore(DateTime(now.year, now.month, now.day))) {
          oldCount++;
        } else {
          todayCount++;
        }
      }
      return [newCount, oldCount, todayCount];
    });
  }
}