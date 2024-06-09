import 'package:doctor_plus/screen/widget/function/button/option.button.dart';
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
          onTap: () => dialog(msg: "google"),
        ),
        buildOptionButton(
          src: 'github',
          onTap: () => dialog(msg: "github"),
        ),
        buildOptionButton(
          src: 'facebook',
          onTap: () => dialog(msg: "facebook"),
        ),
      ],
    );
  }
}
