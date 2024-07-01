import 'package:doctor_plus/core/widgets/app_text_button.dart';
import 'package:doctor_plus/core/widgets/popup_dialog.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentTile extends StatelessWidget {
  final Doctor doctor;
  final AppointmentModel appointment;

  const AppointmentTile({
    super.key,
    required this.doctor,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (appointment.status == "completed")
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment done',
                        style: TextStyle(color: Colors.green),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      SizedBox(height: 4.0),
                    ],
                  )
                : const SizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/imgs/doctor.jpg"),
                ),
                const SizedBox(width: 12.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${doctor.fName} ${doctor.lName}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      appointment.type,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      appointment.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
              ],
            ),
            (appointment.status == "upcoming")
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(thickness: 1.0),
                      const SizedBox(height: 4.0),
                      FractionallySizedBox(
                        widthFactor: .7,
                        child: AppTextButton(
                          buttonText: 'Cancel',
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red[500]!,
                          onPressed: () {
                            buildDialog(
                                msg: "Ary you sure you want to cancel?",
                                okText: "Yes",
                                context: context,
                                onOkPressed: () {
                                  appointment.patientId = context
                                      .read<UserCubit>()
                                      .getUser()
                                      .id!; //context.read<AppointmentCubit>()
                                  context
                                      .read<AppointmentCubit>()
                                      .deleteAppointment(appointment);
                                  Navigator.pop(context);
                                });
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
