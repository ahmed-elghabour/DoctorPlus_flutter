import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_about_tab.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_reviews_tab.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class DoctorProfileTabs extends StatelessWidget {
  DoctorProfileTabs({super.key});

  final List<Widget> _tabs = const [
    Tab(text: 'About'),
    Tab(text: 'Reviews'),
  ];

  final List<Widget> _views = [
    const DoctorAboutTab(),
    const DoctorReviewsTab(),
  ];

  @override
  Widget build(BuildContext context) {
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
        views: _views,
        onChange: (index) => debugPrint(index.toString()),
      ),
    );
  }
}
