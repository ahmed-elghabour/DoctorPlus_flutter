import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource {
  RemoteDataSource();

  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getDoctorUpcomingAppointments(String doctorId) async {
    try {
      final appointmentsCollection = firestore.collection("appointments");
      final QuerySnapshot querySnapshot = await appointmentsCollection
          .where('status', whereIn: ['upcoming', 'rescheduled']).get();

      final List<Map<String, dynamic>> filteredAppointments = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return filteredAppointments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getDoctorCompletedAppointments(String doctorId) async {
    try {
      final appointmentsCollection = firestore.collection("appointments");
      final QuerySnapshot querySnapshot = await appointmentsCollection
          .where('status', whereIn: ['completed']).get();

      final List<Map<String, dynamic>> filteredAppointments = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return filteredAppointments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getDoctorCancelledAppointments(String doctorId) async {
    try {
      final appointmentsCollection = firestore.collection("appointments");
      final QuerySnapshot querySnapshot = await appointmentsCollection
          .where('status', whereIn: ['cancelled']).get();

      final List<Map<String, dynamic>> filteredAppointments = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return filteredAppointments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
