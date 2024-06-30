import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/core/widgets/appbar_icon.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/presentation/appointments/widgets/appointments_tabs.dart';

class DoctorAppointments extends StatelessWidget {
  const DoctorAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserCubit>().getUser();
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
                  create: (context) => AppointmentCubit()
                    ..getPatientAppointments(patientId: user.id),
                ),
              ],
              child: AppointmentsTabs(),
            )
          ],
        ),
      ),
    );
  }
}
