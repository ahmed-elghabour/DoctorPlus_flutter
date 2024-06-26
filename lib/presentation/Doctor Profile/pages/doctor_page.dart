import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    void navigate({required String route}) => Navigator.pushNamed(context, route);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 124, 255),
      appBar: MyCustomAppBar(title: "Profile",actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {
                navigate(route: Routes.settings);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ]),
      
    );
  }
}