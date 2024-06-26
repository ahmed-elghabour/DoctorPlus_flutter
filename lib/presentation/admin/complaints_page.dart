import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AdminComplaintsPage extends StatelessWidget {
  //static const routeName = '/complaintsPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(title: 'Complaints'),
      body: Center(child: Text('Complaints Page')),
    );
  }
}
