import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_about_tab.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_reviews_tab.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class DoctorProfileTabs extends StatelessWidget {
  final Doctor doctor;
  const DoctorProfileTabs({super.key, required this.doctor});

  final List<Widget> _tabs = const [
    Tab(text: 'About'),
    Tab(text: 'Reviews'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      DoctorAboutTab(doctor: doctor,),
      DoctorReviewsTab(
        doctorId: doctor.id!,
        doctorName: "${doctor.fName} ${doctor.lName}",
      ),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height -
          200, // Set height to the available height
      child: ContainedTabBarView(
        tabBarProperties: const TabBarProperties(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        tabs: _tabs,
        views: views,
        onChange: (index) => debugPrint(index.toString()),
      ),
    );
  }
}
