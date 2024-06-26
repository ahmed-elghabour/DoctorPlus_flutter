import 'dart:io';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/data/model/doctor_working_hours.dart';

class Doctor {
  File? image;
  late List<File> files;
  late List<String> degrees;
  late List<ReviewModel> reviews;
  late DoctorWorkingHours workingHours;
  late String university, specialty, graduationDate, description;
  late String type, fName, lName, phone, gender, location, birthDate;

  Doctor({
    required this.degrees,
    required this.university,
    required this.specialty,
    required this.graduationDate,
    required this.type,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.gender,
    required this.location,
    required this.birthDate,
  });

  Doctor.additional({
    required this.files,
    required this.degrees,
    required this.specialty,
    required this.university,
    required this.graduationDate,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      degrees: List<String>.from(json['degrees']),
      university: json['university'],
      specialty: json['specialty'],
      graduationDate: json['graduationDate'],
      type: json['type'],
      fName: json['fName'],
      lName: json['lName'],
      phone: json['phone'],
      gender: json['gender'],
      location: json['location'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degrees': degrees,
      'university': university,
      'specialty': specialty,
      'graduationDate': graduationDate,
      'type': type,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'gender': gender,
      'location': location,
      'birthDate': birthDate,
    };
  }
}
