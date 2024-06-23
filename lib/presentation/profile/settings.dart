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
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text("Notification"),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text("FAQ"),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.lock_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text("Security"),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.language_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text("Language"),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 40,
                  )
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    color: Color.fromARGB(255, 255, 76, 94),
                    Icons.logout_outlined,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Color.fromARGB(255, 255, 76, 94)),
                    ),
                  ),
                  Icon(
                    color: Color.fromARGB(255, 255, 76, 94),
                    Icons.keyboard_arrow_right,
                    size: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
