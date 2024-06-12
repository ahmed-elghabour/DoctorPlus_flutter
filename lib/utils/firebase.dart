import 'package:doctor_plus/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebase {
  static CustomFirebase? auth;

  static CustomFirebase get instance => auth ??= CustomFirebase();

  signWithCredentials({required SystemUser user}) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } catch (e) {
      throw Exception(e);
    }
  }

  createAccountWithCredentials({required SystemUser user}) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } catch (e) {
      throw Exception(e);
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
