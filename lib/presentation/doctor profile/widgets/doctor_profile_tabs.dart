import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_about_tab.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_reviews_tab.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileTabs extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  const DoctorProfileTabs(
      {super.key, required this.doctorId, required this.doctorName});

  final List<Widget> _tabs = const [
    Tab(text: 'About'),
    Tab(text: 'Reviews'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      const DoctorAboutTab(),
      DoctorReviewsTab(
        doctorId: doctorId,
        doctorName: doctorName,
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
