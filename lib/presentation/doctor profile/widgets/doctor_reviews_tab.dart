import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_state.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/review_form.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/review_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReviewsTab extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  const DoctorReviewsTab(
      {super.key, required this.doctorId, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.read<UserCubit>().getUserType() == 'doctor'
            ? const SizedBox()
            : FractionallySizedBox(
                widthFactor: .8,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ReviewForm(
                          doctorId: doctorId,
                          doctorName: doctorName,
                        );
                      },
                    );
                  },
                  child: const Text("Add Review"),
                ),
              ),
        BlocBuilder<DoctorReviewsCubit, DoctorReviewsState>(
          builder: (context, state) {
            // context
            //     .read<DoctorReviewsCubit>()
            //     .getDoctorReviews(doctorId: doctorId);
            if (state is DoctorReviewsLoaded) {
              return Expanded(
                  child: ReviewsListView(reviews: state.doctorReviews));
            } else if (state is DoctorReviewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Errorr loading reviews"),
              );
            }
          },
        ),
      ],
    );
  }
}
