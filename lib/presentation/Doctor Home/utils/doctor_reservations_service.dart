import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/doctor_reservation.dart';

class DoctorService {
  static final CollectionReference reservations = FirebaseFirestore.instance.collection('reservations');

  static Stream<List<DoctorReservation>>? getReservations() {
    //TODO: filter by doctorID
    final reservationsStream = reservations.orderBy('reservationDate', descending: true)
      .snapshots();
      
     return reservationsStream.map((QuerySnapshot query) {
      return query.docs.map((doc) {
        return DoctorReservation.fromFireStore(doc);
      }).toList();
    });
  }
}