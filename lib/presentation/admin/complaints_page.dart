import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminComplaintsPage extends StatelessWidget {
  static const routeName = '/complaintsPage';

  Stream<List<Map<String, dynamic>>> _getComplaints() {
    return FirebaseFirestore.instance
        .collection('Complaints')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaints')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getComplaints(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final complaints = snapshot.data ?? [];
          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return ListTile(
                title: Text(complaint['title'] ?? 'No Title'),
                subtitle: Text(complaint['description'] ?? 'No Description'),
              );
            },
          );
        },
      ),
    );
  }
}
