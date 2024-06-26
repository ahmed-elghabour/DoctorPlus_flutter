import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/core/widgets/card_specialization.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:doctor_plus/presentation/patient%20home/all_doctors.dart';
import 'package:doctor_plus/presentation/patient%20home/all_specializations.dart';
import 'package:doctor_plus/presentation/specialization/specialization_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientHome extends StatelessWidget {
  const PatientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text('How are you today?'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.local_hospital, color: Colors.white, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Book and schedule with nearest doctor',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the navigation
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text('Find Nearby',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Doctor Speciality',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllSpecializationsPage()),
                );
              },
              child: const Text('See More'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: doctorSpecialties.skip(1).map((specialization) {
              return SizedBox(
                width: 150,
                height: 120,
                child: SpecializationCard(
                  title: specialization,
                  imagePath: 'assets/specializations/$specialization.png',
                  onTap: () {
                    navigateToSpecialization(context, specialization);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommendation Doctor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllDoctorsPage()),
                );
              },
              child: const Text('See More'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SizedBox(
            height: 250,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No doctors available'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return DoctorCard(
                      name: data['fName'] ?? 'No Name',
                      speciality: data['specialty'] ?? 'No Speciality',
                      rating: data['rating'] ?? 0.0,
                      reviews: data['reviews'] ?? 0,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void navigateToSpecialization(BuildContext context, String specialization) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SpecializationPage(specialization: specialization),
      ),
    );
  }
}
