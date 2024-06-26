import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/core/widgets/custom_floating_action_button.dart';
import 'package:doctor_plus/data/model/doctor.dart';
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
              DoctorCard(
                doctor: Doctor(
                  degrees: [
                    'MBBS',
                    'MD',
                  ],
                  birthDate: "1990-01-01",
                  fName: 'John',
                  lName: 'Doe',
                  phone: '1234567890',
                  specialty: 'Dermatologist',
                  university: 'University of XYZ',
                  graduationDate: "2020-01-01",
                  type: 'Dermatologist',
                  gender: 'Male',
                  location: 'XYZ, ABC, DEF',
                ),
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
