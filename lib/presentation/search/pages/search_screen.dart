import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:doctor_plus/presentation/search/widgets/search_listview.dart';
import 'package:doctor_plus/presentation/search/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: "Search"),
      body: BlocProvider(
        create: (context) => DoctorsCubit(),
        child: const Column(
          children: [
            SearchTextfield(),
            SearchListview(),
          ],
        ),
      ),
    );
  }
}
