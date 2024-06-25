import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/doctor_reservation.dart';

class DoctorService {
  static final CollectionReference reservations = FirebaseFirestore.instance.collection('reservations');

  static Stream<List<DoctorReservation>>? getReservations(String doctorId) {
    final reservationsStream = reservations.where('doctorId', isEqualTo: doctorId).orderBy('reservationDate', descending: true)
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
        if (reservationDate.isAfter(DateTime(now.year, now.month, now.day))) {
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