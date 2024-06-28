import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/user/user_state.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserStateInitial());

  loadUserData() async {
    emit(UserLoading());
    await CustomFirebase()
        .getDocumentData(docID: SharedPreference().getString(key: "userID")!)
        .then((value) {
      if (value == null) {
        emit(UserLoadingFailure());
      }
      if (value["type"] == "doctor") {
        emit(UserLoadingSuccess());
        return Doctor.fromJson(value);
      } else {
        emit(UserLoadingSuccess());
        return Patient.fromJson(value);
      }
    });
  }
}
