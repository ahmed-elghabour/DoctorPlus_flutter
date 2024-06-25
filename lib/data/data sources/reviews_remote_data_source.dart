import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getDoctorReviews(String doctorId) async {
    try {
      final reviewsCollection = firestore.collection("reviews");
      final QuerySnapshot querySnapshot =
          await reviewsCollection.where('doctorId', whereIn: [doctorId]).get();

      final List<Map<String, dynamic>> reviews = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }
}
