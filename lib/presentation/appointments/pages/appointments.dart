import 'package:doctor_plus/core/widgets/app_bar.dart';
import 'package:doctor_plus/domain/cubits/appointments/cancelled_appointments_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/completed_appointments_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/upcoming_appointments_cubit.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              children: [
                const CustomAppBar(
                  title: 'My Appointments',
                ),
                const SizedBox(
                  height: 8,
                ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => UpcomingAppointmentsCubit()
                          ..getUpcomingAppointments()),
                    BlocProvider(
                        create: (context) => CompletedAppointmentsCubit()
                          ..getCompletedAppointments()),
                    BlocProvider(
                        create: (context) => CancelledAppointmentsCubit()
                          ..getCancelledAppointments()),
                  ],
                  child: AppointmentsTabs(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
