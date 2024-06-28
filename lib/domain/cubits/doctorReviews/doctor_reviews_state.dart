
import 'package:doctor_plus/data/model/review.dart';

sealed class DoctorReviewsState {}

final class DoctorReviewsInitial extends DoctorReviewsState {}

final class DoctorReviewsLoading extends DoctorReviewsState {}

final class DoctorReviewsLoaded extends DoctorReviewsState {
  final List<ReviewModel> doctorReviews;
  DoctorReviewsLoaded(this.doctorReviews);
}

final class DoctorReviewsError extends DoctorReviewsState {
  final String error;
  DoctorReviewsError(this.error);
}
