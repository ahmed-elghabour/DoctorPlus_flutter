import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_state.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is AppointmentsLoaded) {
          return Center(
            child: Text("Upcoming Appointments ${state.upcoming.length}"),
          ); //AppointmentsListView(appointments: state.upcoming);
        } else if (state is AppointmentsLoading) {
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
