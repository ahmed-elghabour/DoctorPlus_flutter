import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/core/widgets/custom_floating_action_button.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/presentation/doctor%20preview/widgets/doctor_profile_tabs.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: 'Dr. John Doe',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const DoctorCard(
                name: "Dr. John Doe",
                speciality: "Cardiologist",
                rating: 4.5,
                reviews: 123,
              ),
              BlocProvider(
                create: (context) =>
                    DoctorReviewsCubit()..getDoctorReviews(doctorId: '123'),
                child: DoctorProfileTabs(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Book Appointment',
        onPressed: () {
          Navigator.pushNamed(context, Routes.bookAppointment,
              arguments: '123');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
