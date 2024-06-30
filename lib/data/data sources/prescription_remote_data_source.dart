import 'package:doctor_plus/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/prescription.dart';

class PrescriptionRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getPrescriptions(String patientId) async {
    try {
      var querySnapshot = await CustomFirebase().getCollectionData(
        isNested: true,
        docID: patientId,
        collection: "patients",
        nestedcollection: "prescriptions",
      );

      // print("Reviews: sdadasdasd");
      // print("Reviews: $querySnapshot");
      List<Map<String, dynamic>> prescriptions = [];
      for (var element in querySnapshot) {
        prescriptions.add(element.data() as Map<String, dynamic>);
      }
      print("Reviews: ${prescriptions.length}");
      print("Reviews: $prescriptions");
      return prescriptions;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addPrescription(Prescription prescription) async {
    try {
      await firestore
          .collection("patients")
          .doc(prescription.patientId)
          .collection("prescriptions")
          .add(prescription.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
