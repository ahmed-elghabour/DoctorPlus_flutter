import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/utils/firebase.dart';

class AppointmentsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getDoctorAppointments(String doctorId) async {
    try {
      List<Map<String, dynamic>> appointments = [];
      await CustomFirebase()
          .getCollectionData(
        isNested: true,
        docID: doctorId,
        collection: "doctors",
        nestedcollection: "appointments",
      )
          .then((value) {
        for (var element in value) {
          appointments.add({
            "id": element.id,
            "date": element.data()["date"],
            "type": element.data()["type"],
            "status": element.data()["status"],
            "payment": element.data()["payment"],
            "patientId": element.data()["patientId"],
            "isUrgant": element.data()["isUrgant"],
          });
        }
      });

      return appointments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getPatientAppointments(String patientId) async {
    try {
      List<Map<String, dynamic>> appointments = [];
      await CustomFirebase()
          .getCollectionData(
              docID: patientId,
              collection: "patients",
              nestedcollection: "appointments",
              isNested: true)
          .then((value) {
        for (var element in value) {
          appointments.add({
            "id": element.id,
            "date": element.data()["date"],
            "type": element.data()["type"],
            "status": element.data()["status"],
            "payment": element.data()["payment"],
            "doctorId": element.data()["doctorId"],
            "isUrgant": element.data()["isUrgant"],
          });
        }
      });

      return appointments;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getAppointmentedDoctors(List<String> doctors) async {
    try {
      List<Map<String, dynamic>> appointmentedDoctors = [];
      for (var doctor in doctors) {
        await CustomFirebase().getDocumentData(docID: doctor).then(
          (value) {
            appointmentedDoctors.add(value);
          },
        );
      }

      return appointmentedDoctors;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getAppointmentedPatients(List<String> patients) async {
    try {
      List<Map<String, dynamic>> appointmentedPatients = [];
      for (var patient in patients) {
        await CustomFirebase().getDocumentData(docID: patient).then(
          (value) {
            appointmentedPatients.add(value);
          },
        );
      }

      return appointmentedPatients;
    } catch (e) {
      throw Exception(e);
    }
  }
}
