import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/card_doctor.dart';

class AllDoctorsPage extends StatelessWidget {
  const AllDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Doctors'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const DoctorCard(
            name: 'Dr. Cullan Sullivan',
            speciality: 'Cardiologist | RSUD Soetomo',
            rating: 4.7,
            reviews: 3241,
          );
        },
      ),
    );
  }
}
