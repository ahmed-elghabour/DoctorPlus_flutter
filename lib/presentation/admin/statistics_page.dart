import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsPage extends StatelessWidget {
  static const routeName = '/statisticsPage';

  const StatisticsPage({super.key});

  Future<Map<String, dynamic>> _getStatistics() async {
    final doctorsSnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    final patientsSnapshot =
        await FirebaseFirestore.instance.collection('patients').get();

    // Calculate statistics
    final appointmentsPerDay =
        await _calculateAppointmentsPerDay(doctorsSnapshot.docs);
    final mostAppointmentsDoctor =
        await _calculateMostAppointmentsDoctor(doctorsSnapshot.docs);
    final highestRatedDoctor =
        await _calculateHighestRatedDoctor(doctorsSnapshot.docs);

    return {
      'totalDoctors': doctorsSnapshot.docs.length,
      'totalPatients': patientsSnapshot.docs.length,
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
                  count: data['appointmentsPerDay']?.values.fold(0, (a, b) => a + b) ?? 0,
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

  Future<Map<String, int>> _calculateAppointmentsPerDay(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final Map<String, int> appointmentsPerDay = {};

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .get();

      for (var appointment in appointmentsSnapshot.docs) {
        final date = appointment['date']
            .toString()
            .split('T')
            .first;
        appointmentsPerDay[date] = (appointmentsPerDay[date] ?? 0) + 1;
      }
    }

    return appointmentsPerDay;
  }

  Future<Map<String, dynamic>> _calculateMostAppointmentsDoctor(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final Map<String, int> doctorAppointmentsCount = {};

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .get();

      doctorAppointmentsCount[doctor.id] = appointmentsSnapshot.docs.length;
    }

    if (doctorAppointmentsCount.isEmpty) {
      return {
        'doctorId': 'N/A',
        'doctorName': 'N/A',
        'count': 0,
      };
    }

    final mostAppointmentsDoctorId = doctorAppointmentsCount.keys.reduce(
        (a, b) =>
            doctorAppointmentsCount[a]! > doctorAppointmentsCount[b]! ? a : b);

    final doctorSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(mostAppointmentsDoctorId)
        .get();
    final doctorData = doctorSnapshot.data();
    final doctorName =
        'Dr. ${doctorData?['fName'] ?? 'Unknown'} ${doctorData?['lName'] ?? ''}';

    return {
      'doctorId': mostAppointmentsDoctorId,
      'doctorName': doctorName,
      'count': doctorAppointmentsCount[mostAppointmentsDoctorId]
    };
  }

  Future<Map<String, dynamic>> _calculateHighestRatedDoctor(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final Map<String, List<double>> doctorRatings = {};

    for (var doctor in doctors) {
      final reviewsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('reviews')
          .get();

      for (var review in reviewsSnapshot.docs) {
        final rating = review['rate'] as double;
        doctorRatings[doctor.id] = (doctorRatings[doctor.id] ?? [])..add(rating);
      }
    }

    if (doctorRatings.isEmpty) {
      return {
        'doctorId': 'N/A',
        'doctorName': 'N/A',
        'rating': 0.0,
      };
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

    final doctorSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(highestRatedDoctorId)
        .get();
    final doctorData = doctorSnapshot.data();
    final doctorName =
        'Dr. ${doctorData?['fName'] ?? 'Unknown'} ${doctorData?['lName'] ?? ''}';

    return {
      'doctorId': highestRatedDoctorId,
      'doctorName': doctorName,
      'rating': highestAvgRating
    };
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
