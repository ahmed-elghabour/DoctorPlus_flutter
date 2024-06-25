import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';

class AppointmentsListView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  const AppointmentsListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentTile(
          appointment: appointments[index],
          onCancel: () {},
          onReschedule: () {},
        );
      },
    );
  }
}
