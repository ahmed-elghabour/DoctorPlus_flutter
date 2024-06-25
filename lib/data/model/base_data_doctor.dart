import 'dart:io';

class DoctorBaseData {
  late List<String> degrees, pdfFiles;
  late String specialty, university, graduationDate;

  DoctorBaseData({
    required String specialty,
    required List<File> files,
    required String university,
    required List<String> degrees,
    required String graduationDate,
  });
}
