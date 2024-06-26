import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/review_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReviewsTab extends StatelessWidget {
  const DoctorReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorReviewsCubit, DoctorReviewsState>(
      builder: (context, state) {
        if (state is DoctorReviewsLoaded) {
          return ReviewsListView(reviews: state.doctorReviews);
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
    );
  }
}
