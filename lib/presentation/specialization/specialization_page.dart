import 'package:doctor_plus/data/model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/presentation/specialization/specialization_doctors.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';

class SpecializationPage extends StatelessWidget {
  final String specialization;

  const SpecializationPage({required this.specialization, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: specialization),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/specializations/$specialization.png'),
                ),
                const SizedBox(height: 16),
                Text(
                  specialization,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('doctors')
                  .where('specialty', isEqualTo: specialization)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No doctors available'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var data =
                        Doctor.fromJson(doc.data() as Map<String, dynamic>);
                    return SpecializationDoctorCard(
                      doctor: data,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
