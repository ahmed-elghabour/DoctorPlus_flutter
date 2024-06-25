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
}
