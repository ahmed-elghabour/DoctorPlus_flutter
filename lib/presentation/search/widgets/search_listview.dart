import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchListview extends StatelessWidget {
  const SearchListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoaded) {
          return Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  return DoctorCard(doctor: state.doctors[index]);
                },
              ),
            ),
          );
        } else if (state is DoctorsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("Errorr loading doctors"),
          );
        }
      },
    );
  }
}
