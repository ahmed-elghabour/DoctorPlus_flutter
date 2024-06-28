import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_state.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is CompletedAppointmentsLoaded) {
          return AppointmentsListView(appointments: state.appointments);
        } else if (state is CompletedAppointmentsLoading) {
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
