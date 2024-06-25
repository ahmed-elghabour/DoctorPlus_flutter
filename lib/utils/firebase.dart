import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebase {
  static CustomFirebase? auth;

  static CustomFirebase get instance => auth ??= CustomFirebase();

  signWithCredentials({required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  createAccountWithCredentials(
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

  getCollectionData(
      {required String? docID, required String collection}) async {
    try {
    return  await FirebaseFirestore.instance.collection(collection).doc(docID).get();
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
