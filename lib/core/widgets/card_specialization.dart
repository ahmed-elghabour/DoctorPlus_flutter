import 'package:flutter/material.dart';

class SpecializationCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SpecializationCard({required this.title, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
