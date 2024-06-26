import 'package:doctor_plus/core/widgets/buttons.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/presentation/Public%20Profile/pages/prescriptions.dart';
import 'package:doctor_plus/presentation/profile/profile.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class PublicProfile extends StatelessWidget {
  const PublicProfile({super.key});
  @override
  Widget build(BuildContext context) {
  final Map<String,dynamic> patient = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic> ;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 124, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(patient['patientName']),
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
                        NameWidget(
                          name: patient['patientName']
                        ),
                        FutureBuilder<Map<String, dynamic>>(
                          future: getPatientData(patient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return const Text('No data found');
                            }
                            final data = snapshot.data!;
                            final filteredData = data.entries
                                .where((entry) =>
                                    entry.key != 'lName' &&
                                    entry.key != 'birthDate' &&
                                    entry.key != 'fName' &&
                                    entry.key != 'phone' &&
                                    entry.key != 'location')
                                .toList();
                            return Column(
                              children: [
                                EmailWidget(
                                  email: data['phone']
                                ),

                                Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: filteredData.map((entry) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                entry.key,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                entry.value =='Select Choice' ? 'NA' : entry.value,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                              ],
                            );
                          }
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: buildSubmitButton(
                            widthFactor: 0.5,
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.prescriptions, arguments: patient);
                                },
                                label: 'View Prescriptions',
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
                  child:  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 224, 219, 175),
                    radius: 70,
                    child: Text(patient['patientName'].split(' ')[0][0].toUpperCase() + patient['patientName'].split(' ')[1][0].toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),),
                  ),
                ))
          ],
        ),
      ),
    );
  }

   Future<Map<String, dynamic>>getPatientData(Map<String,dynamic> patient) async {
    var data = await CustomFirebase().getDocumentData(docID: patient['patientId']!);
    return data;
  }
}