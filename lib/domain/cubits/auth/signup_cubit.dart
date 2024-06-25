import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_plus/data/model/base_data_patient.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  File? image;
  late String fName, type, lName, phone, gender, location, birthDate;
  fillGeneralData({
    required String fName,
    required String type,
    required String lName,
    required String phone,
    required String gender,
    required String location,
    required String birthDate,
    File? image,
  }) {
    this.type = type;
    this.image = image;
    this.fName = fName;
    this.lName = lName;
    this.phone = phone;
    this.gender = gender;
    this.location = location;
    this.birthDate = birthDate;
    // CustomFirebase().addNewCollection(
    //     collection: "users",
    //     docID: SharedPreference().getString(key: 'userID'),
    //     data: {
    //       "type": type,
    //       "fName": fName,
    //       "lName": lName,
    //       "gender": gender,
    //       "location": location,
    //       "birthDate": birthDate,
    //     });
  }

  fetchDoctorAdditionalData({
    required String specialty,
    required List<File> files,
    required String university,
    required List<String> degrees,
    required String graduationDate,
  }) {}

  fetchPatientAdditionalData({required PatientBaseData data}) {
    CustomFirebase().addNewCollection(
        collection: "patients",
        docID: SharedPreference().getString(key: 'userID'),
        data: {
          "fName": fName,
          "lName": lName,
          "gender": gender,
          "location": location,
          "birthDate": birthDate,
        });
  }
}
