import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';

class AppointmentsListView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  final List<Doctor> doctors;
  const AppointmentsListView(
      {super.key, required this.appointments, required this.doctors});

  @override
  Widget build(BuildContext context) {
    // var upcomingAppointmentsCubit =
    //     BlocProvider.of<UpcomingAppointmentsCubit>(context);
    // var cancelledAppointmentsCubit =
    //     BlocProvider.of<CancelledAppointmentsCubit>(context);

    return appointments.isEmpty
        ? const Center(
            child: Text("No Appointments"),
          )
        : ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return AppointmentTile(
                appointment: appointments[index],
                doctor: doctors.firstWhere(
                    (doctor) => doctor.id == appointments[index].doctorId),
              );
            },
          );
  }

  Future<bool> showCancelAppointmentDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Appointment'),
            content: const Text(
                "You are about to cancel this appointment. Are you sure ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
