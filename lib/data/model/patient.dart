import 'package:doctor_plus/data/model/user.dart';

class Patient extends SystemUser {
  late List<String> diseases, medications;
  late String diet,
      smoke,
      sleep,
      stress,
      exercise,
      hydration,
      allergies,
      mentalHealth;

  Patient.additional({
    required this.diet,
    required this.smoke,
    required this.sleep,
    required this.stress,
    required this.exercise,
    required this.hydration,
    required this.allergies,
    required this.mentalHealth,
    required this.diseases,
    required this.medications,
  });

  Patient.login({
    required super.email,
    required super.password,
  }) : super.login();

  Patient.register({
    required super.fName,
    required super.lName,
    required super.email,
    required super.password,
  }) : super.register();

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient.additional(
      diet: map['diet'] ?? '',
      smoke: map['smoke'] ?? '',
      sleep: map['sleep'] ?? '',
      stress: map['stress'] ?? '',
      exercise: map['exercise'] ?? '',
      hydration: map['hydration'] ?? '',
      allergies: map['allergies'] ?? '',
      mentalHealth: map['mentalHealth'] ?? '',
      diseases: List<String>.from(map['diseases'] ?? []),
      medications: List<String>.from(map['medications'] ?? []),
    );
  }
}
