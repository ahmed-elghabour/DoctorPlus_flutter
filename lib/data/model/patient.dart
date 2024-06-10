import 'package:doctor_plus/data/model/user.dart';

class Patient extends SystemUser {
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
