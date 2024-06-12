import 'buttons.dart';
import 'package:flutter/material.dart';

class SwitchAuthPage extends StatelessWidget {
  final String label, link, route;
  const SwitchAuthPage(
      {super.key,
      required this.label,
      required this.link,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        buildTextButton(
            label: link,
            onPressed: () {
              Navigator.pushNamed(context, route);
            }),
      ],
    );
  }
}
