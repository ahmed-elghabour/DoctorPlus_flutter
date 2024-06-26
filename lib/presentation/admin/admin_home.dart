import 'package:doctor_plus/presentation/admin/doctor_managment_page.dart';
import 'package:doctor_plus/presentation/admin/statisticsPage.dart';
import 'package:doctor_plus/presentation/admin/complaints_page.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildCard(
              context,
              'Complaints',
              Icons.report_problem,
              Colors.red,
              ComplaintsPage.routeName,
            ),
            _buildCard(
              context,
              'Statistics',
              Icons.bar_chart,
              Colors.blue,
              StatisticsPage.routeName,
            ),
            _buildCard(
              context,
              'New Doctors',
              Icons.person_add,
              Colors.green,
              DoctorManagmentPage.routeName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
