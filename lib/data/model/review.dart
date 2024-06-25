import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String doctorId;
  final String patientId;
  final String patientImage;
  final String patientName;
  final double rateStars;
  final String reviewText;
  final Timestamp reviewDateTime;

  ReviewModel({
    required this.doctorId,
    required this.patientId,
    required this.patientImage,
    required this.patientName,
    required this.rateStars,
    required this.reviewText,
    required this.reviewDateTime,
  });

  static ReviewModel fromJson(Map<String, dynamic> json) => ReviewModel(
        doctorId: json['doctorId'],
        patientId: json['patientId'],
        patientImage: json['patientImage'],
        patientName: json['patientName'],
        rateStars: json['rateStars'],
        reviewText: json['reviewText'],
        reviewDateTime: json['reviewDateTime'],
      );

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'patientId': patientId,
        'patientImage': patientImage,
        'patientName': patientName,
        'rateStars': rateStars,
        'reviewText': reviewText,
        'reviewDateTime': reviewDateTime,
      };
}
