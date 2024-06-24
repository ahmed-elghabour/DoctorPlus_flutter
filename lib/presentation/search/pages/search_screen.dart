import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/presentation/search/widgets/search_listview.dart';
import 'package:doctor_plus/presentation/search/widgets/search_textfield.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppBar(title: "Search"),
      body: Column(
        children: [
          SearchTextfield(),
          SearchListview(),
        ],
      ),
    );
  }
}
