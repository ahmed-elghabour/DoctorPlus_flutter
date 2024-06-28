import 'package:doctor_plus/data/model/system_user.dart';

class Patient extends SystemUser {
  // String? id;
  late List<String> diseases, medications, favouriteDoctors;
  // late String fName, lName, email, phone, gender, location, birthDate;
  late String diet,
      smoke,
      sleep,
      stress,
      exercise,
      hydration,
      mentalHealth,
      blood;
  Patient.gen({
    super.id = '',
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
    required this.diseases,
    required this.medications,
    required this.blood,
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.hydration,
    required this.mentalHealth,
  });

  Patient({
    super.id = '',
    required this.diseases,
    required this.medications,
    required super.fName,
    required super.lName,
    required super.phone,
    required super.email,
    required super.gender,
    required super.location,
    required super.birthDate,
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.hydration,
    required this.mentalHealth,
    required this.blood,
    this.favouriteDoctors = const [],
  });

  Patient.additional({
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.blood,
    required this.hydration,
    required this.diseases,
    required this.mentalHealth,
    required this.medications,
  }) : super.empty();

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      diseases: List<String>.from(json['diseases']),
      medications: List<String>.from(json['medications']),
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      location: json['location'],
      birthDate: json['birthDate'],
      diet: json['diet'],
      smoke: json['smoke'],
      sleep: json['sleep'],
      stress: json['stress'],
      exercise: json['exercise'],
      hydration: json['hydration'],
      mentalHealth: json['mentalHealth'],
      blood: json['blood'],
      favouriteDoctors: List<String>.from(json['favouriteDoctors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diseases': diseases,
      'medications': medications,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'location': location,
      'birthDate': birthDate,
      'diet': diet,
      'smoke': smoke,
      'sleep': sleep,
      'stress': stress,
      'exercise': exercise,
      'hydration': hydration,
      'mentalHealth': mentalHealth,
      'blood': blood,
      'favouriteDoctors': favouriteDoctors.map((doctorID) => doctorID).toList()
    };
  }
}
