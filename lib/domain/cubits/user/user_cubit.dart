import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/user/user_state.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserStateInitial()) {
    if (SharedPreference().getString(key: "userID") == null) {
      isLoggin = false;
      emit(UserNotLogged());
    } else {
      login();
    }
  }
  late dynamic user;
  bool isLoggin = false;
  loadUserData({String? id}) async {
    await CustomFirebase()
        .getDocumentData(
            docID: id ?? SharedPreference().getString(key: "userID")!)
        .then((value) {
      if (value == null) {
        emit(UserLoggedAndLoadingFailure());
      }
      user = value["type"] == "doctor"
          ? Doctor.fromJson(value)
          : Patient.fromJson(value);
      emit(UserLoggedAndLoadingSuccess(user: user));
    });
  }

  getUser() {
    if (user == null) {
      loadUserData(
          id: SharedPreference().getString(
        key: "userID",
      )!);
    }
    return user;
  }

  login() async {
    emit(UserLoggedAndLoading());
    isLoggin = true;
    await loadUserData();
  }

  logout() {
    isLoggin = false;
    emit(UserNotLogged());
  }

  bool isUsedLogged() => isLoggin;

  String getUserType() => user.type as String;
}
