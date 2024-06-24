import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Settings",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            _settingRow(
              title: "Notification",
              icon: Icons.notifications_none_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _settingRow(
              title: "FAQ",
              icon: Icons.message_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _settingRow(
              title: "Security",
              icon: Icons.lock_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _settingRow(
              title: "Language",
              icon: Icons.language_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _settingRow(
              title: "Logout",
              color: Colors.red,
              icon: Icons.logout_outlined,
              onTap: () {
                CustomFirebase().signOut();
                Navigator.pushReplacementNamed(context, Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _settingRow(
    {required String title,
    Color color = Colors.black,
    required IconData icon,
    required void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: color,
            ),
          ),
        ),
        Icon(
          size: 40,
          Icons.keyboard_arrow_right,
          color: color,
        )
      ],
    ),
  );
}
