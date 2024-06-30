import 'package:doctor_plus/core/widgets/custom_floating_action_button.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/Appointment/pages/appointment.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_profile_data.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/doctor_profile_tabs.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorPreview extends StatelessWidget {
  final Doctor doctor;
  const DoctorPreview({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    context.read<DoctorReviewsCubit>().getDoctorReviews(doctorId: doctor.id!);
    return Scaffold(
      appBar: MyCustomAppBar(
        title: 'Dr. ${doctor.fName} ${doctor.lName}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              DoctorProfileData(doctor: doctor),
              DoctorProfileTabs(
                doctorId: doctor.id!,
                doctorName: "${doctor.fName} ${doctor.lName}",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        text: 'Book Appointment',
        onPressed: () {
          if (!context.read<UserCubit>().isLoggin) {
            FailureToast.showToast(msg: "Please login first");
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentPage(doctor: doctor),
                ));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
