import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/doctor.dart';

class PatientRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<void> addFavoriteDoctorToPatient(
      {required String patientId, required Doctor doctor}) async {
    try {
      final patientDocRef = firestore
          .collection('patients')
          .doc(patientId)
          .collection("favorite_doctors");

      await patientDocRef.doc(doctor.id).set(doctor.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeFavoriteDoctorFromPatient(
      {required String patientId, required String doctorId}) async {
    try {
      final patientDocRef = firestore
          .collection('patients')
          .doc(patientId)
          .collection('favorite_doctors');

      await patientDocRef.doc(doctorId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getFavoriteDoctors(String patientId) async {
    try {
      final patientDocRef = firestore
          .collection('patients')
          .doc(patientId)
          .collection('favorite_doctors');
      final snapshot = await patientDocRef.get();

      final List<Map<String, dynamic>> favoriteDoctors =
          snapshot.docs.map((doc) => doc.data()).toList();

      return favoriteDoctors;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>?> getFavoriteDoctorById(
      {required String patientId, required String doctorId}) async {
    try {
      final patientDocRef = firestore
          .collection('patients')
          .doc(patientId)
          .collection('favorite_doctors');

      final snapshot =
          await patientDocRef.where('id', isEqualTo: doctorId).get();

      if (snapshot.docs.isNotEmpty) {
        final Map<String, dynamic> favoriteDoctor = snapshot.docs.first.data();
        return favoriteDoctor;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
