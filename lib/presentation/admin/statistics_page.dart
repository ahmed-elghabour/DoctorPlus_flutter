import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsPage extends StatelessWidget {
  static const routeName = '/statisticsPage';

  const StatisticsPage({super.key});

  Stream<List<Map<String, dynamic>>> _getDoctors() {
    return FirebaseFirestore.instance.collection('doctors').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  Stream<List<Map<String, dynamic>>> _getPatients() {
    return FirebaseFirestore.instance.collection('patients').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  Stream<List<Map<String, dynamic>>> _getAppointments() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  Future<Map<String, dynamic>> _getStatistics() async {
    final doctorsSnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    final patientsSnapshot =
        await FirebaseFirestore.instance.collection('patients').get();
    final appointmentsSnapshot =
        await FirebaseFirestore.instance.collection('appointments').get();
    final reviewsSnapshot =
        await FirebaseFirestore.instance.collection('reviews').get();

    // Calculate statistics
    final appointmentsPerDay =
        _calculateAppointmentsPerDay(appointmentsSnapshot.docs);
    final mostAppointmentsDoctor =
        _calculateMostAppointmentsDoctor(appointmentsSnapshot.docs);
    final highestRatedDoctor =
        _calculateHighestRatedDoctor(reviewsSnapshot.docs);

    return {
      'totalDoctors': doctorsSnapshot.docs.length,
      'totalPatients': patientsSnapshot.docs.length,
      'totalAppointments': appointmentsSnapshot.docs.length,
      'appointmentsPerDay': appointmentsPerDay,
      'mostAppointmentsDoctor': mostAppointmentsDoctor,
      'highestRatedDoctor': highestRatedDoctor,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: 'Statistics'),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data ?? {};

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildStatisticsCard(
                  title: 'Total Doctors',
                  count: data['totalDoctors'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Total Patients',
                  count: data['totalPatients'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Total Appointments',
                  count: data['totalAppointments'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Doctor with Most Appointments',
                  count: data['mostAppointmentsDoctor']?['count'] ?? 0,
                  subtitle: data['mostAppointmentsDoctor']?['doctorName'],
                ),
                _buildStatisticsCard(
                  title: 'Highest Rated Doctor',
                  count: data['highestRatedDoctor']?['rating']?.toInt() ?? 0,
                  subtitle: data['highestRatedDoctor']?['doctorName'],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatisticsCard(
      {required String title, required int count, String? subtitle}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Text(count.toString()),
      ),
    );
  }

  Map<String, int> _calculateAppointmentsPerDay(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> appointments) {
    final Map<String, int> appointmentsPerDay = {};

    for (var appointment in appointments) {
      final date = (appointment['appointmentDateTime'] as Timestamp)
          .toDate()
          .toIso8601String()
          .split('T')
          .first;
      appointmentsPerDay[date] = (appointmentsPerDay[date] ?? 0) + 1;
    }

    return appointmentsPerDay;
  }

  Map<String, dynamic> _calculateMostAppointmentsDoctor(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> appointments) {
    final Map<String, int> doctorAppointmentsCount = {};

    for (var appointment in appointments) {
      final doctorId = appointment['doctorId'] as String;
      doctorAppointmentsCount[doctorId] =
          (doctorAppointmentsCount[doctorId] ?? 0) + 1;
    }

    final mostAppointmentsDoctorId = doctorAppointmentsCount.keys.reduce(
        (a, b) =>
            doctorAppointmentsCount[a]! > doctorAppointmentsCount[b]! ? a : b);
    return {
      'doctorId': mostAppointmentsDoctorId,
      'count': doctorAppointmentsCount[mostAppointmentsDoctorId]
    };
  }

  Map<String, dynamic> _calculateHighestRatedDoctor(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> reviews) {
    final Map<String, List<double>> doctorRatings = {};

    for (var review in reviews) {
      final doctorId = review['doctorId'] as String;
      final rating = review['rateStars'] as double;
      doctorRatings[doctorId] = (doctorRatings[doctorId] ?? [])..add(rating);
    }

    final highestRatedDoctorId = doctorRatings.keys.reduce((a, b) {
      final avgRatingA =
          doctorRatings[a]!.reduce((a, b) => a + b) / doctorRatings[a]!.length;
      final avgRatingB =
          doctorRatings[b]!.reduce((a, b) => a + b) / doctorRatings[b]!.length;
      return avgRatingA > avgRatingB ? a : b;
    });

    final highestAvgRating =
        doctorRatings[highestRatedDoctorId]!.reduce((a, b) => a + b) /
            doctorRatings[highestRatedDoctorId]!.length;
    return {'doctorId': highestRatedDoctorId, 'rating': highestAvgRating};
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
