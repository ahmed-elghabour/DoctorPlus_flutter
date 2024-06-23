import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/core/widgets/app_text_button.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
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
        child: Row(
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
                    '${appointment.appointmentDate}  |  ${appointment.appointmentTime}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // const Spacer(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
