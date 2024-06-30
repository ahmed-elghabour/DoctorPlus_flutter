import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:flutter/material.dart';

class AppointmentsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getPatientAppointments(String patientId) async {
    try {
      List<AppointmentModel> appointments = [];
      await CustomFirebase()
          .getCollectionData(
              docID: patientId,
              collection: "patients",
              nestedcollection: "appointments",
              isNested: true)
          .then((value) {
        for (var element in value) {
          debugPrint("Patient Appointments - element: ${element.data()}");
          appointments.add(
            AppointmentModel.patient(
              id: element.id,
              date: element.data().date,
              type: element.data().type,
              status: element.data().status,
              payment: element.data().payment,
              doctorId: element.data().doctorId,
              isUrgant: element.data().isUrgant,
            ),
          );
        }
      });
      debugPrint(
          "Patient Appointments - appointmentsDataSource: ${appointments.length}");

      return appointments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
