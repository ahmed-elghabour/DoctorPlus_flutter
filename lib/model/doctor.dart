import 'package:doctor_plus/model/user.dart';

class Doctor extends SystemUser {
  Doctor.login({required super.email, required super.password}) : super.login();
}
