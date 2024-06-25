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
}
