import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/presentation/profile/profile.dart';
import 'package:doctor_plus/utils/firebase.dart';
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
                        EmailWidget(
                          email: patient['patientEmail']
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 19, horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 242, 255),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(15),
                                    width: 60,
                                    child: Image.asset("assets/icons/id.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Personal Information",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 238, 239),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(15),
                                    width: 60,
                                    child:
                                        Image.asset("assets/icons/payment.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Payment",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
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
                    child: Text(patient['patientName'].split(' ')[0][0].toUpperCase() + patient['patientName'].split(' ')[1][0].toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),),
                  ),
                ))
          ],
        ),
      ),
    );
  }

   Future<dynamic>getPtientData(Map<String,dynamic> patient) async {
    var data = await CustomFirebase().getDocumentData(docID: SharedPreference().getString(key: patient['patientName'])!);
    return data;
  }
}