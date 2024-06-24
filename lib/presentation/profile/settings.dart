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
            _buildSettingRow(
              title: "Notification",
              icon: Icons.notifications_none_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _buildSettingRow(
              title: "FAQ",
              icon: Icons.message_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _buildSettingRow(
              title: "Security",
              icon: Icons.lock_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _buildSettingRow(
              title: "Language",
              icon: Icons.language_outlined,
              onTap: () {},
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            _buildSettingRow(
              title: "Logout",
              isSepcial: true,
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

Widget _buildSettingRow(
    {required String title,
    bool isSepcial = false,
    required IconData icon,
    required void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: isSepcial ? Colors.red : Colors.black,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: isSepcial ? Colors.red : Colors.black,
            ),
          ),
        ),
        Icon(
          size: 40,
          Icons.keyboard_arrow_right,
          color: isSepcial ? Colors.red : Colors.black,
        )
      ],
    ),
  );
}
