import 'package:doctor_plus/core/theming/styles.dart';
import 'package:doctor_plus/data/model/review.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final ReviewModel review;

  const ReviewTile({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/imgs/patient.jpg"),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review.patientName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            review.date,
                            style: TextStyles.font13GrayRegular,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${review.rate}',
                        style: TextStyles.font14GrayRegular.copyWith(
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        review.review,
                        style: TextStyles.font14GrayRegular.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
