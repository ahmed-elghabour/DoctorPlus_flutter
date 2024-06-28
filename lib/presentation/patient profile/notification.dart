import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late SharedPreferences pref;

  Map<String, Map<String, dynamic>> data = {
    "settings.notification.Notification_from_DocNow": {
      "name": "Notification from DocNow",
      "value": false,
    },
    "settings.notification.Sound": {
      "name": "Sound",
      "value": false,
    },
    "settings.notification.Vibrate": {
      "name": "Vibrate",
      "value": false,
    },
    "settings.notification.App_Updates": {
      "name": "App Updates",
      "value": false,
    },
    "settings.notification.Special_Offers": {
      "name": "Special Offers",
      "value": false,
    },
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      for (String key in data.keys) {
        data[key]!['value'] = pref.getBool(key) ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Notification",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            String key = data.keys.elementAt(index);
            return _notificationRow(
              title: data[key]!['name'] ?? '',
              value: data[key]!['value'] ?? false,
              onChanged: (value) {
                setState(() {
                  data[key]!['value'] = value;
                  pref.setBool(key, value);
                });
              },
            );
          },
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
