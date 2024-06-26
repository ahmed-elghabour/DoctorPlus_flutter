import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsPage extends StatelessWidget {
  const AllDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: 'All Doctors',
      ),
      body: BlocBuilder<DoctorsCubit, DoctorsState>(
        builder: (context, state) {
          if (state is DoctorsLoaded) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: state.doctors[index],
                  );
                },
                itemCount: state.doctors.length);
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
      ),
    );
  }
}
