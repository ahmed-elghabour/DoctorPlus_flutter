import 'package:cloud_firestore/cloud_firestore.dart';

class PrescriptionService {
  static final CollectionReference prescriptions =
      FirebaseFirestore.instance.collection('prescriptions');

  //create
  static Future addPrescription({
    required String body,
    required String patientId,
    required String doctorId,
  }) async {
    await prescriptions.add({
      'prescriptionBody': body,
      'patientId': patientId,
      'time': Timestamp.now(),
      'doctorId': doctorId
    });
  }

  //read  real-time without get request
  static Stream<QuerySnapshot>? getPrescriptions(String patientId) {
    final userPrescriptionsStream = prescriptions
        .where(
          'patientId',
          isEqualTo: patientId,
        )
        .orderBy('time', descending: true)
        .snapshots();
    return userPrescriptionsStream;
  }

  //UPDATE
  static Future<void> updatePrescription(
      {required String prescriptionId, String? newBody}) async {
    prescriptions
        .doc(prescriptionId)
        .update({'noteBody': newBody, 'time': Timestamp.now()});
  }
}
