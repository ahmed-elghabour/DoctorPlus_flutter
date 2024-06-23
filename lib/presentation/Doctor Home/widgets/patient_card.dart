import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PatientCard extends StatelessWidget {
  final String patientId;
  final String reservationType;
  final DateTime reservationDate;
  final Color color;
  const PatientCard({super.key, required this.patientId, required this.reservationType, required this.reservationDate, required this.color});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 30,
          child: const Text('AY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(patientId, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),
            Text(reservationType, style: TextStyle(color: color,fontSize: 14,),)
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
            "${reservationDate.hour.toString().padLeft(2, '0')}:${reservationDate.minute.toString().padLeft(2, '0')}",
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
            ),
          )
        )
      ],
    );
  }
}