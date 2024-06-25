import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  fillGeneralData({
    required String type,
    required String fName,
    required String lName,
    required String gender,
    required String location,
    required String birthDate,
    File? image,
  }) async {
    CustomFirebase().addNewCollection(
        collection: "users",
        docID: SharedPreference().getString(key: 'userID'),
        data: {
          "type": type,
          "fName": fName,
          "lName": lName,
          "gender": gender,
          "location": location,
          "birthDate": birthDate,
        });
  }
}
