import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomFirebase {
  static CustomFirebase? auth;

  static CustomFirebase get instance => auth ??= CustomFirebase();

  signWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential);
        return auth.currentUser?.uid;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  signWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // await addNewCollection(
      //   collection: "users",
      //   docID: user.user!.uid,
      //   data: {
      //     "email": email,
      //     "password": hashPassword(password),
      //   },
      // );
      return user.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser!;
  }

  Future<void> addNewCollection({
    String? docID,
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (docID != null) {
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(docID)
            .set(data);
      } else {
        await FirebaseFirestore.instance.collection(collection).add(data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  getCollectionData({required String collection}) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      return snapshot.docs;
    } catch (e) {
      throw Exception(e);
    }
  }

  getDocumentData({required String docID, String? collection}) async {
    try {
      if (collection != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection(collection)
            .doc(docID)
            .get();
        return snapshot.data();
      } else {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("patients")
            .doc(docID)
            .get();
        if (snapshot.data() != null) {
          return snapshot.data();
        } else if (snapshot.data() == null) {
          snapshot = await FirebaseFirestore.instance
              .collection("doctors")
              .doc(docID)
              .get();
          return snapshot.data();
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
