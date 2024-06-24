import 'package:flutter/material.dart';

class SearchListviewTile extends StatelessWidget {
  const SearchListviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
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
