import 'package:doctor_plus/data/data%20sources/reviews_remote_data_source.dart';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/data/repositories/reviews_repository.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DoctorReviewsCubit extends Cubit<DoctorReviewsState> {
  DoctorReviewsCubit() : super(DoctorReviewsInitial());

  void getDoctorReviews({required String doctorId}) async {
    emit(DoctorReviewsLoading());
    try {
      List<ReviewModel> doctorReviews =
          await ReviewsRepository(remoteDataSource: ReviewsRemoteDataSource())
              .getDoctorReviews(doctorId);

      emit(DoctorReviewsLoaded(doctorReviews));
    } catch (e) {
      emit(DoctorReviewsError(e.toString()));
    }
  }
}
