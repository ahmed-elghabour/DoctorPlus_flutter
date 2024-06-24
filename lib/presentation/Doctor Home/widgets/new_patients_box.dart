import 'package:flutter/material.dart';

class PatientsBox extends StatelessWidget {
  final int patients;
  final String patientType;
  const PatientsBox({super.key, required this.patients, required this.patientType});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 120,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 191, 230, 248),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientType,
                  style: const TextStyle(
                      fontSize: 15, color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '$patients',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ])),
    );
  }
}