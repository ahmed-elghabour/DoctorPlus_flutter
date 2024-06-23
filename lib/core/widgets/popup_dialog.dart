import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

AwesomeDialog buildDialog({
  required String msg,
  required String okText,
  required BuildContext context,
  required void Function()? onOkPressed,
  // required void Function()? onCancelPressed,
  DialogType type = DialogType.info,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: type,
    animType: AnimType.scale,
    body: Center(
      child: Text(
        msg,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnOkText: okText,
    btnCancelText: 'Cancel',
    btnOkOnPress: onOkPressed,
    btnCancelOnPress: () {},
  )..show();
}

AwesomeDialog buildCustomDialog({
  required List<Widget> widgets,
  required String okText,
  required BuildContext context,
  required void Function()? onOkPressed,
}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.info,
    body: Center(
      child: Column(
        children: widgets,
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnOkText: okText,
    btnCancelText: 'Cancel',
    btnOkOnPress: onOkPressed,
    btnCancelOnPress: () {},
  )..show();
}
