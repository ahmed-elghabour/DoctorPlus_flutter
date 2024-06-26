import 'package:doctor_plus/data/model/doctor.dart';

class Patient {
  late List<String> diseases, medications;
  late List<Doctor> preferedDoctors;
  late String fName, lName, type, phone, gender, location, birthDate;
  late String diet,
      smoke,
      sleep,
      stress,
      exercise,
      hydration,
      mentalHealth,
      allergies;

  Patient({
    required this.diseases,
    required this.medications,
    required this.fName,
    required this.lName,
    required this.type,
    required this.phone,
    required this.gender,
    required this.location,
    required this.birthDate,
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.hydration,
    required this.mentalHealth,
    required this.allergies,
    this.preferedDoctors = const [],
  });

  Patient.additional({
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.allergies,
    required this.hydration,
    required this.diseases,
    required this.mentalHealth,
    required this.medications,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      diseases: List<String>.from(json['diseases']),
      medications: List<String>.from(json['medications']),
      fName: json['fName'],
      lName: json['lName'],
      type: json['type'],
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
      allergies: json['allergies'],
      preferedDoctors: List<Doctor>.from(
        json['preferedDoctors']
            .map((doctorJson) => Doctor.fromJson(doctorJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diseases': diseases,
      'medications': medications,
      'fName': fName,
      'lName': lName,
      'type': type,
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
      'allergies': allergies,
      'preferedDoctors':
          preferedDoctors.map((doctor) => doctor.toJson()).toList()
    };
  }
}
