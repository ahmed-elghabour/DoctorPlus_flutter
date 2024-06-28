import 'dart:io';

abstract class SystemUser {
  String? id;
  File? image;
  late String fName, lName, email, phone, gender, location, birthDate;

  SystemUser.empty();
  SystemUser({
    this.id = '',
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.location,
    required this.birthDate,
  });

 
}
