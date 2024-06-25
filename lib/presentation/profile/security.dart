import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  late SharedPreferences pref;

  Map<String, Map<String, dynamic>> Data = {
    "settings.security.Remember_Password": {
      "name": "Remember Password",
      "value": false,
    },
    "settings.security.Face_ID": {
      "name": "Face ID",
      "value": false,
    },
    "settings.security.PIN": {
      "name": "PIN",
      "value": false,
    },
    "settings.security.Google_Authenticator": {
      "name": "Google Authenticator",
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
      for (String key in Data.keys) {
        Data[key]!['value'] = pref.getBool(key) ?? false;
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
          itemCount: Data.length,
          itemBuilder: (context, index) {
            String key = Data.keys.elementAt(index);
            return _securityRow(
              title: Data[key]!['name'] ?? '',
              value: Data[key]!['value'] ?? false,
              onChanged: (value) {
                setState(() {
                  Data[key]!['value'] = value;
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

Widget _securityRow({
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
