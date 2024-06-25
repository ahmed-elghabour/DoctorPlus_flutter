import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  void navigate({required String route}) => Navigator.pushNamed(context, route);

  final TextEditingController searchController = TextEditingController();
  String selectedLanguage = 'English';
  List<String> languages = [
    'Arabic',
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Russian',
    'Portuguese',
    'Hindi'
  ];

  List<String> filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    filteredLanguages = languages;
    searchController.addListener(_filterLanguages);
  }

  void _filterLanguages() {
    setState(() {
      filteredLanguages = languages
          .where((lang) =>
              lang.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onLanguageSelected(String language) {
    if (language != 'English') {
      _showLanguageNotSupportedDialog();
      setState(() {
        selectedLanguage = 'English';
      });
    } else {
      setState(() {
        selectedLanguage = language;
      });
    }
  }

  Future<dynamic> _showLanguageNotSupportedDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language Not Supported'),
        content: const Text(
            'The selected language is not supported yet. Defaulting to English.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(
        title: "Language",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildSearchField(controller: searchController),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLanguages.length,
                itemBuilder: (context, index) {
                  String language = filteredLanguages[index];
                  return Column(
                    children: [
                      _languageRow(
                        name: language,
                        selected: selectedLanguage == language,
                        onTap: () => _onLanguageSelected(language),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

Widget _languageRow({
  required String name,
  required bool selected,
  required VoidCallback onTap,
}) {
  return ListTile(
    title: Text(name),
    trailing: Radio<String>(
      value: name,
      groupValue: selected ? name : '',
      onChanged: (value) {
        onTap();
      },
    ),
    onTap: onTap,
  );
}

Widget buildSearchField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: "Search",
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
