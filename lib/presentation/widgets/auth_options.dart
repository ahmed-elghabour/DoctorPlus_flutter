import 'buttons.dart';
import 'package:flutter/material.dart';

class ExternalSignOptions extends StatelessWidget {
  const ExternalSignOptions({super.key});

  @override
  Widget build(BuildContext context) {
    void dialog({required String msg}) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(msg),
            ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOptionButton(
          src: 'google',
          onTap: () => dialog(msg: "Google"),
        ),
        buildOptionButton(
          src: 'apple',
          onTap: () => dialog(msg: "Apple ID"),
        ),
        buildOptionButton(
          icon: Icons.phone_android,
          iconSize: 28,
          onTap: () => dialog(msg: "Phone"),
        ),
        // buildOptionButton(
        //   src: 'facebook',
        //   onTap: () => dialog(msg: "facebook"),
        // ),
      ],
    );
  }
}
