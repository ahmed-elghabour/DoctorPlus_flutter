import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getPatientUpcomingAppointments(String patientId) async {
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

  Future<List<dynamic>> getPatientCompletedAppointments(
      String patientId) async {
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

  Future<List<dynamic>> getPatientCancelledAppointments(
      String patientId) async {
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
