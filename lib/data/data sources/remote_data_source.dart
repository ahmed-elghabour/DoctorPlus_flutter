import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataSource {
  RemoteDataSource();

  Future<List<dynamic>> getDoctorPendingAppointments(String doctorId) async {
    try {
      final appointmentsCollection =
          FirebaseFirestore.instance.collection("appointments");
      final QuerySnapshot querySnapshot = await appointmentsCollection
          .where('status', whereIn: ['pending', 'rescheduled']).get();

      final List<Map<String, dynamic>> filteredAppointments = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return filteredAppointments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
