import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/presentation/doctor%20profile/widgets/review_tile.dart';
import 'package:flutter/material.dart';

class ReviewsListView extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsListView({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return reviews.isEmpty
        ? const Center(
            child: Text("No Reviews"),
          )
        : ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewTile(
                review: reviews[index],
              );
            },
          );
  }
}
