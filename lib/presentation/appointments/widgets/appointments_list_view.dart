import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/domain/cubits/appointments/cancelled_appointments_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/upcoming_appointments_cubit.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsListView extends StatelessWidget {
  final List<AppointmentModel> appointments;
  const AppointmentsListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    var upcomingAppointmentsCubit =
        BlocProvider.of<UpcomingAppointmentsCubit>(context);
    var cancelledAppointmentsCubit =
        BlocProvider.of<CancelledAppointmentsCubit>(context);

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentTile(
          appointment: appointments[index],
          onCancel: () {
            // first we change the status of the appointment to cancelled in database
            upcomingAppointmentsCubit.cancelPatientUpcomingAppointment(
              appointmentId: appointments[index].id,
              patientId: '123',
            );

            // then i get the appointments again
            upcomingAppointmentsCubit.getPatientUpcomingAppointments(
                patientId: '123');
            cancelledAppointmentsCubit.getPatientCancelledAppointments(
                patientId: '123');
          },
          onReschedule: () {},
        );
      },
    );
  }
}
