import 'package:doctor_plus/presentation/Doctor%20Home/widgets/doctorHome_info_card.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/patient_list.dart';
import 'package:doctor_plus/utils/greeting.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final String doctorName = "Amr";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //remove sized box later
              const SizedBox(height: 60,),
              RichText(
                text: TextSpan(
                  text: getGreeting(),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$doctorName !',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF3E36B0))
                    )
                  ]
                ),
              ),
              const doctorHomeCard(),
              const SizedBox(height: 20,),
              const PatientList(),
            ],
          ),
        ),
      ),
    );
  }
}