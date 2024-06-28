import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/doctor.dart';

class PatientRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<void> addPreferedDoctorToPatient(
      {required String patientId, required Doctor doctor}) async {
    final patientDocRef = firestore.collection('patients').doc(patientId);
    final preferedDoctorsCollectionRef =
        patientDocRef.collection('preferedDoctors');

    try {
      await preferedDoctorsCollectionRef.doc(doctor.id).set(doctor.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removePreferedDoctorFromPatient(
      {required String patientId, required String doctorId}) async {
    final patientDocRef = firestore.collection('patients').doc(patientId);
    final preferedDoctorsCollectionRef =
        patientDocRef.collection('preferedDoctors');
    try {
      await preferedDoctorsCollectionRef.doc(doctorId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getPreferedDoctors(String patientId) async {
    final patientDocRef = firestore.collection('patients').doc(patientId);
    final preferedDoctorsCollectionRef =
        patientDocRef.collection('preferedDoctors');

    try {
      final snapshot = await preferedDoctorsCollectionRef.get();

      final List<Map<String, dynamic>> preferedDoctors =
          snapshot.docs.map((doc) => doc.data()).toList();

      return preferedDoctors;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>?> getPreferedDoctorById(
      {required String patientId, required String doctorId}) async {
    try {
      final patientDocRef = firestore.collection('patients').doc(patientId);
      final preferedDoctorsCollectionRef =
          patientDocRef.collection('preferedDoctors');

      final snapshot = await preferedDoctorsCollectionRef
          .where('id', isEqualTo: doctorId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final Map<String, dynamic> preferedDoctor = snapshot.docs.first.data();
        return preferedDoctor;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
