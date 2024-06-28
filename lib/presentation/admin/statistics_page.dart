import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsPage extends StatelessWidget {
  static const routeName = '/statisticsPage';

  const StatisticsPage({super.key});

  Stream<List<Map<String, dynamic>>> _getDoctors() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> _getPatients() {
    return FirebaseFirestore.instance
        .collection('patients')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> _getAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: 'Statistics'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getDoctors(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final doctors = snapshot.data ?? [];
                return _buildStatisticsCard(
                  title: 'Total Doctors',
                  count: doctors.length,
                );
              },
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getPatients(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final patients = snapshot.data ?? [];
                return _buildStatisticsCard(
                  title: 'Total Patients',
                  count: patients.length,
                );
              },
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getAppointments(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final appointments = snapshot.data ?? [];
                return _buildStatisticsCard(
                  title: 'Total Appointments',
                  count: appointments.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard({required String title, required int count}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        trailing: Text(count.toString()),
      ),
    );
  }
}
