import 'dart:io';

import 'package:doctor_plus/data/model/user.dart';

class Doctor extends SystemUser {
  late List<String> degrees, pdfFiles;
  late String specialty, university, graduationDate;

  Doctor.additional({
    required String specialty,
    required List<File> files,
    required String university,
    required List<String> degrees,
    required String graduationDate,
  });
  Doctor.login({required super.email, required super.password}) : super.login();
}
