import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentTile(
          appointment: appointment,
          onCancel: () {},
          onReschedule: () {},
        );
      },
    );
  }
}
