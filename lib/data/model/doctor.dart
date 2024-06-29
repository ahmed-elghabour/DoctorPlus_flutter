import 'dart:io';
import 'package:doctor_plus/data/model/review.dart';
import 'package:doctor_plus/data/model/doctor_working_.dart';
import 'package:doctor_plus/data/model/system_user.dart';

class Doctor extends SystemUser {
  @override
  File? image;
  // late String id;
  late List<File> files;
  late int fees, patients;
  late List<String> degrees;
  late List<ReviewModel> reviews;
  late DoctorWorkingHours workingDays;
  late String university, specialty, graduationDate, description;
  // late String email, fName, lName, phone, gender, location, birthDate;

  Doctor.basic({
    super.type = 'doctor',
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
  });

  Doctor.gen({
    super.id = '',
    super.type = 'doctor',
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
    required this.fees,
    required this.degrees,
    required this.patients,
    required this.specialty,
    required this.university,
    required this.description,
    required this.workingDays,
    required this.graduationDate,
  });
  Doctor.additional({
    required this.fees,
    required this.files,
    required this.degrees,
    required this.patients,
    required this.specialty,
    required this.university,
    required this.workingDays,
    required this.description,
    required this.graduationDate,
  }) : super.empty();

  Doctor.profile({
    required super.id,
    super.type = 'doctor',
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
  });
  Doctor.test({
    required super.id,
    super.type = 'doctor',
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
    required this.description,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor.gen(
      id: json['id'],
      type: json['type'],
      degrees: List<String>.from(json['degrees']),
      university: json['university'],
      specialty: json['specialty'],
      graduationDate: json['graduationDate'],
      email: json['email'],
      fName: json['fName'],
      lName: json['lName'],
      phone: json['phone'],
      gender: json['gender'],
      fees: json['fees'],
      patients: json['patients'],
      description: json['description'],
      workingDays: DoctorWorkingHours(
        days: List<String>.from(json['days']),
        endTimes: json['endingWorkHour'],
        startTimes: json['startingWorkHour'],
      ),
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
