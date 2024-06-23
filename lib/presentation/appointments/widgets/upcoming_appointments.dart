import 'package:doctor_plus/domain/cubits/appointments/upcoming_appointments_cubit.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
      builder: (context, state) {
        if (state is UpcomingAppointmentsLoaded) {
          return AppointmentsListView(appointments: state.appointments);
        } else if (state is UpcomingAppointmentsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Errorr loading appointments"),
          );
        }
      },
    );
  }
}
