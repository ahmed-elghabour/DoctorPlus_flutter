import 'dart:io';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/auth/signup_state.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  saveDemoDoctorAdditionalData({required Doctor data, required String id}) {
    CustomFirebase().addNewCollection(collection: "doctors", docID: id, data: {
      "id": id,
      "fName": data.fName,
      "lName": data.lName,
      "phone": data.phone,
      "email": data.email,
      "gender": data.gender,
      "type": "doctor",
      "location": data.location,
      "birthDate": data.birthDate,
      "degrees": data.degrees, //
      "specialty": data.specialty, //
      "university": data.university, //
      "graduationDate": data.graduationDate, //
      "description": data.description, //
      "fees": data.fees, //
      "patients": data.patients, //
      "startingWorkHour": data.workingDays.startTimes,
      "endingWorkHour": data.workingDays.endTimes,
      "days": data.workingDays.days,
      // "image": image,
    });
  }

  saveDemoPatientAdditionalData({required Patient data, required String id}) {
    CustomFirebase().addNewCollection(collection: "patients", docID: id, data: {
      "id": id,
      "type": "patient",
      "email": data.email,
      "fName": data.fName,
      "lName": data.lName,
      "phone": data.phone,
      "gender": data.gender,
      "location": data.location,
      "birthDate": data.birthDate,
      "diet": data.diet,
      "diseases": data.diseases,
      "medications": data.medications,
      "smoke": data.smoke,
      "sleep": data.sleep,
      "stress": data.stress,
      "exercise": data.exercise,
      "hydration": data.hydration,
      "blood": data.blood,
      "mentalHealth": data.mentalHealth,
    });
    SharedPreference().setString(key: "userType", value: "patient");
  }

  saveDoctorAdditionalData({required Doctor data, required String id}) {
    CustomFirebase().addNewCollection(collection: "doctors", docID: id, data: {
      "id": id,
      "fName": fName,
      "lName": lName,
      "phone": phone,
      "gender": gender,
      "type": "doctor",
      "location": location,
      "birthDate": birthDate,
      "degrees": data.degrees, //
      "specialty": data.specialty, //
      "university": data.university, //
      "graduationDate": data.graduationDate, //
      "description": data.description, //
      "fees": data.fees, //
      "patients": data.patients, //
      "startingWorkHour": data.workingDays.startTimes,
      "endingWorkHour": data.workingDays.endTimes,
      "days": data.workingDays.days,
      // "image": image,
    });
    SharedPreference().setString(key: "userType", value: "doctor");
  }

  savePatientAdditionalData({required Patient data}) {
    CustomFirebase().addNewCollection(
        collection: "patients",
        docID: SharedPreference().getString(key: 'userID')!,
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
          "blood": data.blood,
          "mentalHealth": data.mentalHealth,
        });
    SharedPreference().setString(key: "userType", value: "patient");
  }
}
