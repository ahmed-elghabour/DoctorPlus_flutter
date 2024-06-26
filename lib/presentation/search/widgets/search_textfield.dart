import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        onChanged: (query) {
          BlocProvider.of<DoctorsCubit>(context).searchDoctors(query);
        },
        decoration: const InputDecoration(
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
