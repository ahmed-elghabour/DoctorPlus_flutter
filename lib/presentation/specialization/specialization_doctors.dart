import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/presentation/doctor%20profile/pages/doctor_preview.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class SpecializationDoctorCard extends StatelessWidget {
  final Doctor doctor;

  const SpecializationDoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorPreview(doctor: doctor)));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(
                  'assets/imgs/doctor.jpg',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${doctor.fName} ${doctor.lName}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.phone,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
