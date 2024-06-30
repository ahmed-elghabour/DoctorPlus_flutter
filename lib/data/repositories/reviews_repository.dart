import 'package:doctor_plus/data/data%20sources/reviews_remote_data_source.dart';
import 'package:doctor_plus/data/model/review.dart';

class ReviewsRepository {
  final ReviewsRemoteDataSource remoteDataSource;
  ReviewsRepository({required this.remoteDataSource});

  Future<List<ReviewModel>> getDoctorReviews(String doctorId) async {
    try {
      List<dynamic> reviews = await remoteDataSource.getDoctorReviews(doctorId);

      return reviews.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDoctorReview(ReviewModel reviewModel, String doctorId) async {
    try {
      await remoteDataSource.addDoctorReview(reviewModel, doctorId);
    } catch (e) {
      rethrow;
    }
  }
}
