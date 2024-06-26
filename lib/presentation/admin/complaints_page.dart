import 'package:flutter/material.dart';

class ComplaintsPage extends StatelessWidget {
  static const routeName = '/complaintsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaints')),
      body: const Center(child: Text('Complaints Page')),
    );
  }
}
