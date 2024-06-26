import 'package:doctor_plus/core/widgets/toast.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';

import '../../../core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ExternalSignOptions extends StatelessWidget {
  const ExternalSignOptions({super.key});
  @override
  Widget build(BuildContext context) {
    navigate({required String route}) => Navigator.pushNamed(context, route);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOptionButton(
          src: 'google',
          onTap: () async {
            try {
              var user = await CustomFirebase().signWithGoogle();
              SharedPreference().setString(key: 'userID', value: user);
              var document =
                  await CustomFirebase().getDocumentData(docID: user);

              if (document == null) {
                navigate(route: Routes.registerFill);
                return;
              }
              SharedPreference().setString(
                  key: 'userType',
                  value: document["stress"] != null ? "patient" : "doctor");
              navigate(route: Routes.home);
            } catch (e) {
              FailureToast.showToast(msg: e.toString());
            }
          },
        ),
        // buildOptionButton(
        //   src: 'apple',
        //   onTap: () => dialog(msg: "Apple ID"),
        // ),
        // buildOptionButton(
        //   icon: Icons.phone_android,
        //   iconSize: 28,
        //   onTap: () => dialog(msg: "Phone"),
        // ),
        // buildOptionButton(
        //   src: 'facebook',
        //   onTap: () => dialog(msg: "facebook"),
        // ),
      ],
    );
  }
}
