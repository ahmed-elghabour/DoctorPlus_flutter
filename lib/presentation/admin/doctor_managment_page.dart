import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DoctorManagmentPage extends StatelessWidget {
  //static const routeName = '/newDoctorsPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(title: 'Doctor Managment'),
      body: Center(child: Text('Doctor Managment Page')),
    );
  }
}
