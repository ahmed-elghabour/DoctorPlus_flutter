import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:doctor_plus/data/model/base_data_doctor.dart';
import 'package:doctor_plus/data/model/base_data_patient.dart';

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
  }

  saveDoctorAdditionalData({required DoctorBaseData data}) {
    CustomFirebase().addNewCollection(
        collection: "doctors",
        docID: SharedPreference().getString(key: 'userID'),
        data: {
          "fName": fName,
          "lName": lName,
          "phone": phone,
          "gender": gender,
          "location": location,
          "birthDate": birthDate,
          "degrees": data.degrees,
          "specialty": data.specialty,
          "university": data.university,
          "specialization": data.specialty,
          "graduationDate": data.graduationDate,
        });
    SharedPreference().setString(key: "userType", value: "doctor");
  }

  savePatientAdditionalData({required PatientBaseData data}) {
    CustomFirebase().addNewCollection(
        collection: "patients",
        docID: SharedPreference().getString(key: 'userID'),
        data: {
          "fName": fName,
          "lName": lName,
          "phone": phone,
          "gender": gender,
          "location": location,
          "birthDate": birthDate,
          "diet": data.diet,
          "smoke": data.smoke,
          "sleep": data.sleep,
          "stress": data.stress,
          "exercise": data.exercise,
          "hydration": data.hydration,
          "allergies": data.allergies,
          "mentalHealth": data.mentalHealth,
        });
    SharedPreference().setString(key: "userType", value: "patient");
  }
}
