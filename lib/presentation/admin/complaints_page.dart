import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminComplaintsPage extends StatelessWidget {
  static const routeName = '/complaintsPage';

  const AdminComplaintsPage({super.key});

  Stream<List<Map<String, dynamic>>> _getComplaints() {
    return FirebaseFirestore.instance.collection('Complaints').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
  }

  Future<void> _deleteComplaint(BuildContext context, String id) async {
    await FirebaseFirestore.instance.collection('Complaints').doc(id).delete();
    SuccessToast.showToast(msg: 'Complaint deleted successfully');
  }

  void _showComplaintDialog(
      BuildContext context, Map<String, dynamic> complaint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complaint from ${complaint['personName']}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Body: ${complaint['body']}'),
                const SizedBox(height: 16),
                Text('Solution: ${complaint['solution']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await _deleteComplaint(context, complaint['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: 'Complaints'),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getComplaints(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final complaints = snapshot.data ?? [];
          if (complaints.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(complaint['personName'] ?? 'No Name'),
                  subtitle: Text(complaint['personEmail'] ?? 'No Email'),
                  onTap: () => _showComplaintDialog(context, complaint),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
