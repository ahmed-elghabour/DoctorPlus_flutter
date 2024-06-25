import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  void navigate({required String route}) => Navigator.pushNamed(context, route);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Language",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            buildSearchField(controller: searchController),
            const SizedBox(
              height: 20,
            ),
            _languageRow(name: "English", selected: true),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _languageRow({
  required String name,
  required bool selected,
}) {
  var groupValue;
  return Row(
    children: [
      Expanded(
        child: Text(
          name,
        ),
      ),
      Radio(value: name, groupValue: name, onChanged: (value) {})
    ],
  );
}

Widget buildSearchField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: "Search",
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
