import 'package:doctor_plus/core/widgets/my_custom_app_bar_no_back.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBarNoBack(title: 'Admin'),
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
              Routes.adminComplaints,
            ),
            _buildCard(
              context,
              'Statistics',
              Icons.bar_chart,
              Colors.blue,
              Routes.adminStatistics,
            ),
            _buildCard(
              context,
              'New Doctors',
              Icons.person_add,
              Colors.green,
              Routes.doctorManagement,
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
