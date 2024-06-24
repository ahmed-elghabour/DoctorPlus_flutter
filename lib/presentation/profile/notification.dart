import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Map<String, bool> Data = {
    "Notification from DocNow": true,
    "Sound": true,
    "Vibrate": true,
    "App Updates": false,
    "Special Offers": true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Notification",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            _notificationRow(
                title: "Notification from DocNow",
                value: Data["Notification from DocNow"] ?? false,
                onChanged: (value) {
                  setState(() {
                    Data["Notification from DocNow"] = value;
                  });
                }),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _notificationRow(
                title: "Sound",
                value: Data["Sound"] ?? false,
                onChanged: (value) {
                  setState(() {
                    Data["Sound"] = value;
                  });
                }),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _notificationRow(
                title: "Vibrate",
                value: Data["Vibrate"] ?? false,
                onChanged: (value) {
                  setState(() {
                    Data["Vibrate"] = value;
                  });
                }),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _notificationRow(
                title: "App Updates",
                value: Data["App Updates"] ?? false,
                onChanged: (value) {
                  setState(() {
                    Data["App Updates"] = value;
                  });
                }),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _notificationRow(
                title: "Special Offers",
                value: Data["Special Offers"] ?? false,
                onChanged: (value) {
                  setState(() {
                    Data["Special Offers"] = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

Widget _notificationRow({
  required String title,
  Color color = Colors.black,
  bool value = false,
  required void Function(bool)? onChanged,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
      Switch(value: value, onChanged: onChanged),
    ],
  );
}
