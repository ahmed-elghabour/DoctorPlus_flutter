import 'package:doctor_plus/core/widgets/app_text_button.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentTile extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;

  const AppointmentTile({
    super.key,
    required this.appointment,
    required this.onCancel,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (appointment.status == AppointmentStatus.done)
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
            (appointment.status == AppointmentStatus.cancelled)
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment cancelled',
                        style: TextStyle(color: Colors.red),
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(appointment.doctorImage),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appointment.doctorName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(50.0),
                            splashColor: Colors.blue[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svgs/chat.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        appointment.appointmentType,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${appointment.appointmentDateTime}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      (appointment.status == AppointmentStatus.pending ||
                              appointment.status ==
                                  AppointmentStatus.rescheduled)
                          ? Column(
                              children: [
                                const Divider(thickness: 1.0),
                                const SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: AppTextButton(
                                        buttonText: 'Reschedule',
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        onPressed: onReschedule,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: AppTextButton(
                                        buttonText: 'Cancel',
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.red[500]!,
                                        onPressed: onReschedule,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
