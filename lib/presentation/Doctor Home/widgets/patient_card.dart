import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final Color color;
  final Patient patient;
  final String type;
  final String date;
  const PatientCard({
    super.key,
    required this.color,
    required this.patient,
    required this.type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 30,
          child: Text(
            '${patient.fName[0].toUpperCase()}${patient.lName[0].toUpperCase()}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              '${patient.fName} ${patient.lName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                color: color,
                fontSize: 14,
              ),
            )
          ],
        ),
        const Spacer(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              date,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    );
  }
}
