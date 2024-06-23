import 'package:doctor_plus/core/widgets/app_bar.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_tabs.dart';
import 'package:flutter/material.dart';

class DoctorAppointments extends StatelessWidget {
  const DoctorAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomAppBar(
                  title: 'My Appointments',
                ),
                const SizedBox(
                  height: 20,
                ),
                AppointmentsTabs()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
