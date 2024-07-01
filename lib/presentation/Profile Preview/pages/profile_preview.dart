import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/Profile%20Preview/pages/prescriptions.dart';
import 'package:doctor_plus/presentation/patient%20profile/profile.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientPreview extends StatelessWidget {
  final Patient patient;
  final AppointmentModel? appointment;
  const PatientPreview({super.key, required this.patient, this.appointment});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 124, 255),
      appBar: MyCustomAppBar(
        isDefault: false,
        title: "${patient.fName} ${patient.lName}",
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 90),
                        NameWidget(name: "${patient.fName} ${patient.lName}"),
                        Column(
                          children: [
                            EmailWidget(email: patient.phone),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...patient
                                        .toJson()
                                        .entries
                                        .where((entry) =>
                                            entry.key != 'lName' &&
                                            entry.key != 'birthDate' &&
                                            entry.key != 'fName' &&
                                            entry.key != 'email' &&
                                            entry.key != 'phone' &&
                                            entry.key != 'location' &&
                                            entry.key != 'favouriteDoctors' &&
                                            entry.key != 'diseases' &&
                                            entry.key != 'medications')
                                        .map((entry) {
                                      return entryWidget(entry);
                                    }),
                                    entryListWidget(
                                        entry: patient.diseases,
                                        title: "Diseases"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    entryListWidget(
                                        entry: patient.medications,
                                        title: "Medications"),
                                  ]),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 8, left: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: buildSubmitButton(
                                  // widthFactor: 0.9,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PatientPrescriptions(
                                                  patient: patient),
                                        ));
                                  },
                                  label: 'View Prescriptions',
                                ),
                              ),
                              const SizedBox(width: 8),
                              appointment == null
                                  ? const SizedBox()
                                  : Expanded(
                                      flex: 2,
                                      child: buildSubmitButton(
                                        // widthFactor: 0.3,
                                        bgColor: Colors.green,
                                        onPressed: () {
                                          try {
                                            appointment!.doctorId = context
                                                .read<UserCubit>()
                                                .getUser()
                                                .id;
                                            context
                                                .read<AppointmentCubit>()
                                                .markAppointmentAsDone(
                                                    appointment!);
                                            Navigator.pushNamed(
                                                context, Routes.home);
                                            SuccessToast.showToast(
                                              msg: "Appointment marked as done",
                                            );
                                          } catch (e) {
                                            FailureToast.showToast(
                                                msg: e.toString());
                                          }
                                        },
                                        label: 'Done',
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              top: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // Set the border color
                      width: 4.0, // Set the border width
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFB3CBDB),
                    radius: 70,
                    child: Text(
                      '${patient.fName[0].toUpperCase()}${patient.lName[0].toUpperCase()}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getPatientData(
      Map<String, dynamic> patient) async {
    var data =
        await CustomFirebase().getDocumentData(docID: patient['patientId']!);
    return data;
  }
}

Widget entryWidget(entry) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          entry.key[0].toUpperCase() + entry.key.substring(1),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          entry.value == 'Select Choice' ? 'NA' : entry.value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget entryListWidget({required List<String> entry, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: entry.map((item) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                        Text(item, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
            top: -12,
            left: 15,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
      ],
    ),
  );
}
