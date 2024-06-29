import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/user/user_state.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserStateInitial()) {
    if (SharedPreference().getString(key: "userID") == null) {
      emit(UserNotLogged());
    } else {
      emit(UserLogged());
    }
  }
  late dynamic user;
  bool isLoggin = false;
  loadUserData({String? id}) async {
    await CustomFirebase()
        .getDocumentData(
            docID: id ?? SharedPreference().getString(key: "userID")!)
        .then((value) {
      print("Document Value: $value");
      if (value == null) {
        emit(UserLoadingFailure());
      }

      if (value["type"] == "doctor") {
        user = Doctor.fromJson(value);
        emit(UserLoadingSuccess());
      } else {
        user = Patient.fromJson(value);
        emit(UserLoadingSuccess());
      }
    });
    print("Trace Login - Type is: ${user.type}");
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

  login() async{
    await loadUserData();
    isLoggin = true;
    emit(UserLogged());
  }

  logout() {
    isLoggin = false;
    emit(UserNotLogged());
  }

  bool isUsedLogged() => isLoggin;
}
