import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

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
    final appointmentsToday =
        await _calculateAppointmentsToday(doctorsSnapshot.docs);
    final appointmentsLastWeek =
        await _calculateAppointmentsLastWeek(doctorsSnapshot.docs);
    final appointmentsLastMonth =
        await _calculateAppointmentsLastMonth(doctorsSnapshot.docs);
    final mostAppointmentsDoctorThisWeek =
        await _calculateMostAppointmentsDoctorThisWeek(doctorsSnapshot.docs);
    final mostAppointmentsDoctorThisMonth =
        await _calculateMostAppointmentsDoctorThisMonth(doctorsSnapshot.docs);
    final topRatedDoctorLastMonth =
        await _calculateTopRatedDoctorLastMonth(doctorsSnapshot.docs);

    return {
      'totalDoctors': doctorsSnapshot.docs.length,
      'totalPatients': patientsSnapshot.docs.length,
      'appointmentsPerDay': appointmentsPerDay,
      'mostAppointmentsDoctor': mostAppointmentsDoctor,
      'highestRatedDoctor': highestRatedDoctor,
      'appointmentsToday': appointmentsToday,
      'appointmentsLastWeek': appointmentsLastWeek,
      'appointmentsLastMonth': appointmentsLastMonth,
      'mostAppointmentsDoctorThisWeek': mostAppointmentsDoctorThisWeek,
      'mostAppointmentsDoctorThisMonth': mostAppointmentsDoctorThisMonth,
      'topRatedDoctorLastMonth': topRatedDoctorLastMonth,
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
                  count: data['appointmentsPerDay']
                          ?.values
                          .fold(0, (a, b) => a + b) ??
                      0,
                ),
                _buildStatisticsCard(
                  title: 'Appointments Today',
                  count: data['appointmentsToday'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Appointments Last Week',
                  count: data['appointmentsLastWeek'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Appointments Last Month',
                  count: data['appointmentsLastMonth'] ?? 0,
                ),
                _buildStatisticsCard(
                  title: 'Doctor with Most Appointments',
                  count: data['mostAppointmentsDoctor']?['count'] ?? 0,
                  subtitle: data['mostAppointmentsDoctor']?['doctorName'],
                ),
                _buildStatisticsCard(
                  title: 'Doctor with Most Appointments This Week',
                  count: data['mostAppointmentsDoctorThisWeek']?['count'] ?? 0,
                  subtitle: data['mostAppointmentsDoctorThisWeek']
                      ?['doctorName'],
                ),
                _buildStatisticsCard(
                  title: 'Doctor with Most Appointments This Month',
                  count: data['mostAppointmentsDoctorThisMonth']?['count'] ?? 0,
                  subtitle: data['mostAppointmentsDoctorThisMonth']
                      ?['doctorName'],
                ),
                _buildStatisticsCard(
                  title: 'Highest Rated Doctor',
                  count: data['highestRatedDoctor']?['rating']?.toInt() ?? 0,
                  subtitle: data['highestRatedDoctor']?['doctorName'],
                ),
                _buildStatisticsCard(
                  title: 'Top Rated Doctor Last Month',
                  count:
                      data['topRatedDoctorLastMonth']?['rating']?.toInt() ?? 0,
                  subtitle: data['topRatedDoctorLastMonth']?['doctorName'],
                ),
                _buildAppointmentsPerDayChart(data['appointmentsPerDay'] ?? {}),
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
        final date = appointment['date'].toString().split('T').first;
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
        doctorRatings[doctor.id] = (doctorRatings[doctor.id] ?? [])
          ..add(rating);
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

  Future<int> _calculateAppointmentsToday(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    int appointmentsToday = 0;

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .where('date', isEqualTo: today)
          .get();

      appointmentsToday += appointmentsSnapshot.docs.length;
    }

    return appointmentsToday;
  }

  Future<int> _calculateAppointmentsLastWeek(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final lastWeek = now.subtract(const Duration(days: 7));
    int appointmentsLastWeek = 0;

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .where('date',
              isGreaterThanOrEqualTo: DateFormat('yyyy-MM-dd').format(lastWeek))
          .get();

      appointmentsLastWeek += appointmentsSnapshot.docs.length;
    }

    return appointmentsLastWeek;
  }

  Future<int> _calculateAppointmentsLastMonth(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));
    int appointmentsLastMonth = 0;

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .where('date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(lastMonth))
          .get();

      appointmentsLastMonth += appointmentsSnapshot.docs.length;
    }

    return appointmentsLastMonth;
  }

  Future<Map<String, dynamic>> _calculateMostAppointmentsDoctorThisWeek(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final Map<String, int> doctorAppointmentsCount = {};

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .where('date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(startOfWeek))
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

  Future<Map<String, dynamic>> _calculateMostAppointmentsDoctorThisMonth(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final Map<String, int> doctorAppointmentsCount = {};

    for (var doctor in doctors) {
      final appointmentsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('appointments')
          .where('date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(startOfMonth))
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

  Future<Map<String, dynamic>> _calculateTopRatedDoctorLastMonth(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> doctors) async {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));
    final Map<String, List<double>> doctorRatings = {};

    for (var doctor in doctors) {
      final reviewsSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .collection('reviews')
          .where('date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(lastMonth))
          .get();

      for (var review in reviewsSnapshot.docs) {
        final rating = review['rate'] as double;
        doctorRatings[doctor.id] = (doctorRatings[doctor.id] ?? [])
          ..add(rating);
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

  Widget _buildAppointmentsPerDayChart(Map<String, int> appointmentsPerDay) {
    final List<FlSpot> spots = [];
    final List<String> dateLabels = [];

    DateTime now = DateTime.now();

    for (int i = 2; i >= 0; i--) {
      DateTime day = now.subtract(Duration(days: i));
      String dayStr = DateFormat('yyyy-MM-dd').format(day);
      int count = appointmentsPerDay[dayStr] ?? 0;
      spots.add(FlSpot((2 - i).toDouble(), count.toDouble()));
      dateLabels.add(DateFormat('dd MMM').format(day)); // Format as "dd MMM"
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Appointments Per Day (Last 3 Days)'),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < dateLabels.length) {
                              return Text(
                                dateLabels[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value % 2 == 0) {
                              return Text(value.toInt().toString());
                            }
                            return const Text('');
                          },
                          reservedSize: 28,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 2,
                        color: Colors.blue,
                        belowBarData: BarAreaData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
