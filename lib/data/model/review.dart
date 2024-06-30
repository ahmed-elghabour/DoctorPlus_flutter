class ReviewModel {
  final String patientId;
  final String patientName;
  final double rate;
  final String review;
  final String date;

  ReviewModel({
    required this.patientId,
    required this.patientName,
    required this.rate,
    required this.review,
    required this.date,
  });

  static ReviewModel fromJson(Map<String, dynamic> json) => ReviewModel(
        patientId: json['patientId'],
        patientName: json['patientName'],
        rate: json['rate'],
        review: json['review'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'patientName': patientName,
        'rate': rate,
        'review': review,
        'date': date,
      };
}
