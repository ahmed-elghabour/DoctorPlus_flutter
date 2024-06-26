import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebase {
  static CustomFirebase? auth;

  static CustomFirebase get instance => auth ??= CustomFirebase();

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

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
