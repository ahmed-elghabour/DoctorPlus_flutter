import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/presentation/Public%20Profile/utils/prescription_service.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
  final Map<String,dynamic> patient = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic> ;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showNoteBox(context, patient['patientId'], SharedPreference().getString(key: "userID")!);
          },
          child: const Icon(Icons.add),
      ),
      appBar: const MyCustomAppBar(title: 'Prescriptions',),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 12,
                ),

                const Row(
                children: [
                  Text(
                    "Hello these are the prescriptions",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(
                  height: 12,
              ),
                  StreamBuilder<QuerySnapshot>(
                    stream: PrescriptionService.getPrescriptions(patient['patientId']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.isEmpty ? 1: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text("No Prescriptions"),
                              );
                            } else {
                              var prescription = snapshot.data!.docs[index];
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        prescription['prescriptionBody'] ?? "",
                                        style: const TextStyle(
                                            fontSize: 22,
                                        ),
                                      ), 
                                      const SizedBox(height: 10,),

                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('yyyy-MM-dd').format(prescription['time'].toDate()),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                              ),
                                            ),
                                            const Spacer(),
                                            FutureBuilder(
                                              future: getDoctorName(prescription['doctorId']),
                                              builder: (context, snapshot) {
                                                final String doctorName = snapshot.data ?? "";
                                                return Text(
                                                  'Dr. $doctorName',
                                                  style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey
                                              ),);
                                              }
                                             )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return const Text("something went wrong");
                      }
                    })
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> showNoteBox(BuildContext context, String patientId, String doctorId, {String? oldBody, String? prescriptionId}) {
  TextEditingController bodyTextEditingController = TextEditingController();

  if (oldBody != null && prescriptionId != null) {
    bodyTextEditingController.text = oldBody;
  }

  late String addOrEdit;

  if (oldBody != null && prescriptionId != null) {
    addOrEdit = 'Edit';
  } else {
    addOrEdit = 'Add';
  }

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text('$addOrEdit your prescription'),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    decoration: const InputDecoration(hintText: "Prescription Body"),
                    maxLines: null,
                    controller: bodyTextEditingController),
                    
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await PrescriptionService.addPrescription(
                      body: bodyTextEditingController.text,
                      patientId: patientId,
                      doctorId: doctorId
                  );
                  Navigator.pop(context);
                },
                child: Text('$addOrEdit Prescription'),
              )
            ],
          ));
}

 Future<String>getDoctorName(String doctorId) async {
    var data = await CustomFirebase().getDocumentData(docID: doctorId);
    return data['fName'] + " " + data['lName'];
  }
