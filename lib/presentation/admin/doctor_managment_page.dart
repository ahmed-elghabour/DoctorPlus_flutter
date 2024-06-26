import 'package:flutter/material.dart';

class DoctorManagmentPage extends StatelessWidget {
  static const routeName = '/newDoctorsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Managment')),
      body: Center(child: const Text('Doctor Managment Page')),
    );
  }
}
