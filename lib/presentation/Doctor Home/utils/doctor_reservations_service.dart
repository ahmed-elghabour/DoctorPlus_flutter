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
  
  static Stream<int> getPatientsNumAtDay(String doctorId){
    final reservationStream = reservations.where('doctorId', isEqualTo: doctorId).snapshots();
    return reservationStream.map((snapshot) => snapshot.docs.length);
  }
}