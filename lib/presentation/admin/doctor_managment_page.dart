import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorManagmentPage extends StatelessWidget {
  static const routeName = '/doctorManagementPage';

  Stream<List<Map<String, dynamic>>> _getDoctors() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Doctors')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getDoctors(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final doctors = snapshot.data ?? [];
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return ListTile(
                title: Text(doctor['name'] ?? 'No Name'),
                subtitle: Text(doctor['specialty'] ?? 'No Specialty'),
              );
            },
          );
        },
      ),
    );
  }
}
