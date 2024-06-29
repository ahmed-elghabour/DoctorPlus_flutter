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
    super.type = 'patient',
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
    super.type = 'patient',
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
    required this.blood,
    required this.stress,
    required this.exercise,
    required this.diseases,
    required this.hydration,
    required this.mentalHealth,
    required this.medications,
  }) : super.empty();

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      type: json['type'],
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
      phone: json['phone'],
      diet: json['diet'],
      blood: json['blood'],
      smoke: json['smoke'],
      sleep: json['sleep'],
      gender: json['gender'],
      stress: json['stress'],
      exercise: json['exercise'],
      location: json['location'],
      birthDate: json['birthDate'],
      hydration: json['hydration'],
      mentalHealth: json['mentalHealth'],
      diseases: List<String>.from(json['diseases']),
      medications: List<String>.from(json['medications']),
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
