import 'package:doctor_plus/core/theming/styles.dart';
import 'package:flutter/material.dart';

class DoctorAboutTab extends StatelessWidget {
  const DoctorAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("About Me", style: TextStyles.font18DarkBlueSemiBold),
            ),
            Text(
              "Dr. Jenny Watson is the top most Immunologists specialist in Christ Hospital at London. She achived several awards for her wonderful contribution in medical field. She is available for private consultation.",
              style: TextStyles.font14GrayRegular.copyWith(
                height: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Working Hours",
                  style: TextStyles.font18DarkBlueSemiBold),
            ),
            Text(
              "Monday - Friday, 08.00 AM - 20.00 PM",
              style: TextStyles.font14GrayRegular.copyWith(
                height: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Licences", style: TextStyles.font18DarkBlueSemiBold),
            ),
            Text(
              "STR Pengalaman Praktik",
              style: TextStyles.font14GrayRegular.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
