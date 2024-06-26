import 'dart:math';

import 'package:doctor_plus/data/data%20sources/reviews_remote_data_source.dart';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/data/repositories/reviews_repository.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReviewsCubit extends Cubit<DoctorReviewsState> {
  DoctorReviewsCubit() : super(DoctorReviewsInitial());

  List<ReviewModel> reviews = [];
  void getDoctorReviews({required String doctorId}) async {
    emit(DoctorReviewsLoading());
    try {
      reviews =
          await ReviewsRepository(remoteDataSource: ReviewsRemoteDataSource())
              .getDoctorReviews(doctorId);
      print("reviews: ${reviews.length}");
      emit(DoctorReviewsLoaded(reviews, calcRate()));
    } catch (e) {
      emit(DoctorReviewsError(e.toString()));
    }
  }

  addDoctorReview(
      {required ReviewModel reviewModel, required String doctorId}) async {
    emit(DoctorReviewsLoading());
    try {
      await ReviewsRepository(remoteDataSource: ReviewsRemoteDataSource())
          .addDoctorReview(reviewModel, doctorId);
      reviews.add(reviewModel);
      emit(DoctorReviewsLoaded(reviews, calcRate()));
    } catch (e) {
      emit(DoctorReviewsError(e.toString()));
    }
  }

  calcRate() {
    print("reviews: ${reviews.length}");
    List<double> rates = reviews.map((e) => e.rate).toList();
    double rate = 0;
    for (double elm in rates) {
      rate += elm;
    }
    return (rate / rates.length).toInt();
  }
}
