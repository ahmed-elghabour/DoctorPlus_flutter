import 'dart:io';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/data/model/doctor_working_.dart';

class Doctor {
  File? image;
  late String id;
  late List<File> files;
  late int fees, patients;
  late List<String> degrees;
  late List<ReviewModel> reviews;
  late DoctorWorkingHours workingDays;
  late String university, specialty, graduationDate, description;
  late String email, fName, lName, phone, gender, location, birthDate;

  Doctor({
    this.id = '',
    this.email = '',
    required this.degrees,
    required this.university,
    required this.specialty,
    required this.graduationDate,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.gender,
    required this.location,
    required this.birthDate,
    this.description = '',
    this.reviews = const [],
    // this.workingHours = const DoctorWorkingHours( days: [], endTimes: [], startTimes: [], ),
  });

  Doctor.additional({
    required this.files,
    required this.degrees,
    required this.specialty,
    required this.university,
    required this.graduationDate,
    required this.workingDays,
    required this.description,
    required this.fees,
    required this.patients,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      degrees: List<String>.from(json['degrees']),
      university: json['university'],
      specialty: json['specialty'],
      graduationDate: json['graduationDate'],
      email: json['email'],
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
      'id': id,
      'degrees': degrees,
      'university': university,
      'specialty': specialty,
      'graduationDate': graduationDate,
      'email': email,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'gender': gender,
      'location': location,
      'birthDate': birthDate,
    };
  }

  double getRating() {
    double sum = 0;
    for (var element in reviews) {
      sum += element.rateStars;
    }
    return sum / reviews.length;
  }
}
