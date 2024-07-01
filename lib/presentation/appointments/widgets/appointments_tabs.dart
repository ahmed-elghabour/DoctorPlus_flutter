import 'package:doctor_plus/presentation/appointments/widgets/cancelled_appointments.dart';
import 'package:doctor_plus/presentation/appointments/widgets/completed_appointments.dart';
import 'package:doctor_plus/presentation/appointments/widgets/upcoming_appointments.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class AppointmentsTabs extends StatelessWidget {
  AppointmentsTabs({super.key});

  final List<Widget> _tabs = const [
    Tab(text: 'Upcoming'),
    Tab(text: 'Completed'),
    // Tab(text: 'Cancelled'),
  ];

  final List<Widget> _views = [
    const UpcomingAppointments(),
    const CompletedAppointments(),
    // const CancelledAppointments(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height -
          168, // Set height to the available height
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        tabs: _tabs,
        views: _views,
        onChange: (index) => debugPrint(index.toString()),
      ),
    );
  }
}
