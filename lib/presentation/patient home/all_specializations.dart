import 'package:doctor_plus/presentation/specialization/specialization_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/card_specialization.dart';
import 'package:doctor_plus/data/demo.dart';

class AllSpecializationsPage extends StatelessWidget {
  const AllSpecializationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Specializations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: doctorSpecialties.length - 1,
          itemBuilder: (context, index) {
            final specialization = doctorSpecialties[index + 1];
            return SpecializationCard(
              title: specialization,
              imagePath: 'assets/specializations/$specialization.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SpecializationPage(specialization: specialization),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
