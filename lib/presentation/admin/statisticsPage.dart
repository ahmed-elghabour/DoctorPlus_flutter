import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  //static const routeName = '/statisticsPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(title: 'Statistics'),
      body: Center(child: Text('Statistics Page')),
    );
  }
}
