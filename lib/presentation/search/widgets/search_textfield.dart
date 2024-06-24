import 'package:doctor_plus/core/theming/colors.dart';
import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for doctor or department",
          prefixIcon: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.search,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            borderSide: BorderSide.none,
          ),
          fillColor: ColorsManager.lighterGray,
          filled: true,
        ),
      ),
    );
  }
}
