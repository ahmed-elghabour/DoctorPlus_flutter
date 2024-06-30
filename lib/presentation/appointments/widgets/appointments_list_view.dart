import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';

class AppointmentsListView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  const AppointmentsListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    // var upcomingAppointmentsCubit =
    //     BlocProvider.of<UpcomingAppointmentsCubit>(context);
    // var cancelledAppointmentsCubit =
    //     BlocProvider.of<CancelledAppointmentsCubit>(context);

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentTile(
          appointment: appointments[index],
          onCancel: () async {
            // bool shouldCancelApppointment =
            //     await showCancelAppointmentDialog(context);

            // if (shouldCancelApppointment) {
            //   // first we change the status of the appointment to cancelled in database
            //   upcomingAppointmentsCubit.cancelPatientUpcomingAppointment(
            //     appointmentId: appointments[index].id,
            //     patientId: '123',
            //   );

            //   // then i get the appointments again
            //   upcomingAppointmentsCubit.getPatientUpcomingAppointments(
            //       patientId: '123');
            //   cancelledAppointmentsCubit.getPatientCancelledAppointments(
            //       patientId: '123');
            // }
          },
          onReschedule: () {},
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
