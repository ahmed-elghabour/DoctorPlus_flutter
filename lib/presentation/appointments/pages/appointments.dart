import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/core/widgets/appbar_icon.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/domain/cubits/appointments/cancelled_appointments_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/completed_appointments_cubit.dart';
import 'package:doctor_plus/domain/cubits/appointments/upcoming_appointments_cubit.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_tabs.dart';

class DoctorAppointments extends StatelessWidget {
  const DoctorAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: 'My Appointments',
        actions: [
          appBarIcon(
            iconSize: 30,
            icon: Icons.person_search,
            onTap: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        UpcomingAppointmentsCubit()..getUpcomingAppointments()),
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
    );
  }
}
