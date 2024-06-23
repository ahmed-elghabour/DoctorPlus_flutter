import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/presentation/appointments/widgets/upcoming_appointments.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class AppointmentsTabs extends StatelessWidget {
  AppointmentsTabs({super.key});

  final List<Widget> _tabs = const [
    Tab(text: 'Upcoming'),
    Tab(text: 'Completed'),
    Tab(text: 'Cancelled'),
  ];

  final List<Widget> _views = [
    const UpcomingAppointments(),
    const Center(child: Text('Completed')),
    const Center(child: Text('Cancelled')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // color: Colors.blue,
      width: double.infinity,
      height: 500,
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          labelColor: ColorsManager.mainBlue,
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
