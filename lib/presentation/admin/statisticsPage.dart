import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  static const routeName = '/statisticsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(child: const Text('Statistics Page')),
    );
  }
}
