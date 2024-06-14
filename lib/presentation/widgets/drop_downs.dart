import 'package:flutter/material.dart';

Widget genderDropDownMenu({
  required String value,
  required void Function(String?) onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      isExpanded: true,
      onChanged: onChanged,
      items: <String>['Male', 'Female']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(child: Text(value)),
        );
      }).toList(),
    ),
  );
}
