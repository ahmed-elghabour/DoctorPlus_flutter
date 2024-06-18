import 'package:flutter/material.dart';

class ComplaintDepartment extends StatefulWidget {
  const ComplaintDepartment({super.key});

  @override
  State<ComplaintDepartment> createState() => _ComplaintDepartmentState();
}

class _ComplaintDepartmentState extends State<ComplaintDepartment> {
  List<String>list = ["dept","dept2","dept3","dept4"];
  String dropdownValue = 'dept';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Department", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        const SizedBox(
          height: 10,
        ),
        DropdownButton(
          value: dropdownValue,
          isExpanded: true,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: Container(
            height: 2,
            color: Colors.indigo,
          ),
          onChanged: (String? value) {  
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      ],
    );
  }
}