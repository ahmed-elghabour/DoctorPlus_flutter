import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class SearchListviewTile extends StatelessWidget {
  const SearchListviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.doctorProfile);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/imgs/docIcon.jpg')),
          title: Text(
            'Dr. John Doe',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
          ),
          trailing: Text("Dummy"),
        ),
      ),
    );
  }
}
