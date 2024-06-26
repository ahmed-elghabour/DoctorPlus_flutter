import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getRecommendedDoctors(
      {required String patientId}) async {
    try {
      final doctorsCollection = firestore.collection("doctors");
      final QuerySnapshot querySnapshot =
          await doctorsCollection.limit(5).get();

      final List<Map<String, dynamic>> doctors = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return doctors;
    } catch (e) {
      throw Exception(e);
    }
  }
}
