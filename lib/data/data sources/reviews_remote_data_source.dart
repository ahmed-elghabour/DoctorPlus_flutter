import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/utils/firebase.dart';

class ReviewsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getDoctorReviews(String doctorId) async {
    try {
      var querySnapshot = await CustomFirebase().getCollectionData(
        isNested: true,
        docID: doctorId,
        collection: "doctors",
        nestedcollection: "reviews",
      );

      // print("Reviews: sdadasdasd");
      // print("Reviews: $querySnapshot");
      List<Map<String, dynamic>> reviews = [];
      for (var element in querySnapshot) {
        reviews.add(element.data() as Map<String, dynamic>);
      }
      print("Reviews: ${reviews.length}");
      print("Reviews: $reviews");
      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addDoctorReview(ReviewModel reviewModel, String doctorId) async {
    try {
      await firestore
          .collection("doctors")
          .doc(doctorId)
          .collection("reviews")
          .add(reviewModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
