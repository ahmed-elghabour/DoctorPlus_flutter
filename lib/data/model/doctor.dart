import 'dart:io';

import 'package:doctor_plus/data/model/user.dart';

class Doctor extends SystemUser {
  late List<String> degrees;
  late List<File> files;
  late String specialty, university, graduationDate;

  Doctor.additional({
    required this.specialty,
    required this.files,
    required this.university,
    required this.degrees,
    required this.graduationDate,
  });
  Doctor.login({required super.email, required super.password}) : super.login();

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor.additional(
      specialty: map['specialty'] ?? '',
      university: map['university'] ?? '',
      graduationDate: map['graduationDate'] ?? '',
      degrees: List<String>.from(map['degrees'] ?? []),
      files: (map['files'] as List).map((filePath) => File(filePath)).toList(),
    );
  }
}
