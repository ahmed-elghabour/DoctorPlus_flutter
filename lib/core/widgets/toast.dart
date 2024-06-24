import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralToast {
  static void showToast({
    required String msg,
    double fontSize = 16,
    Color? bgColor = Colors.black,
    Color? textColor = Colors.white,
    Toast? length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      toastLength: length,
      textColor: textColor,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

class FailureToast {
  static void showToast({
    required String msg,
    double fontSize = 16,
    Toast? length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      toastLength: length,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

class SuccessToast {
  static void showToast({
    required String msg,
    double fontSize = 16,
    Toast? length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: fontSize,
      toastLength: length,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
    );
  }
}
