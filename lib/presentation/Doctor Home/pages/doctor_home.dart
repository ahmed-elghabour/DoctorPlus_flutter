import 'package:doctor_plus/presentation/Doctor%20Home/widgets/doctorHome_info_card.dart';
import 'package:doctor_plus/presentation/doctor%20home/widgets/patient_list.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/greeting.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    const String doctorName = "Amr";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //remove sized box later
              const SizedBox(
                height: 60,
              ),
              RichText(
                text: TextSpan(
                    text: getGreeting(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    children: const <TextSpan>[
                      TextSpan(
                          text: '$doctorName !',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF3E36B0)))
                    ]),
              ),
              const DoctorHomeCard(),
              const SizedBox(
                height: 20,
              ),
              const PatientList(),
            ],
          ),
        ),
      ),
    );
  }
}
