import 'package:doctor_plus/domain/cubits/recommendedDoctors/recommended_doctors_cubit.dart';
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
      body: BlocBuilder<RecommendedDoctorsCubit, RecommendedDoctorsState>(
        builder: (context, state) {
          if (state is RecommendedDoctorsLoaded) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return DoctorCard(
                    doctor: state.recommendedDoctors[index],
                  );
                },
                itemCount: state.recommendedDoctors.length);
          } else if (state is RecommendedDoctorsLoading) {
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
