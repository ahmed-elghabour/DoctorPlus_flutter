import 'package:doctor_plus/core/widgets/app_text_button.dart';
import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ReviewForm extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  const ReviewForm(
      {super.key, required this.doctorId, required this.doctorName});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  double _currentRating = 3;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    try {
      var patient = context.read<UserCubit>().getUser();
      context.read<DoctorReviewsCubit>().addDoctorReview(
          doctorId: widget.doctorId,
          reviewModel: ReviewModel(
            patientId: patient.id,
            patientName: patient.fName + " " + patient.lName,
            rate: _currentRating,
            review: _reviewController.text,
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          ));
      SuccessToast.showToast(msg: "Review added successfully");
      Navigator.of(context).pop();
    } catch (e) {
      FailureToast.showToast(msg: e.toString());
    }
  }

  void _cancelReview() {
    Navigator.of(context).pop(); // Close the bottom sheet
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Your Review",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter your review",
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Text(
              "Rate: ${_currentRating.toInt()} stars",
              style: const TextStyle(fontSize: 18),
            ),
            _buildRatingStars(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextButton(
                      buttonText: "Cancel",
                      buttonHeight: 50,
                      backgroundColor: Colors.red,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _cancelReview),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppTextButton(
                      buttonText: "Submit",
                      buttonHeight: 50,
                      backgroundColor: Colors.blue,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      onPressed: _submitReview),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
