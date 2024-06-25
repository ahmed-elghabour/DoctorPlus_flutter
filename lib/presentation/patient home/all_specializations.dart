import 'package:flutter/material.dart';
import 'package:doctor_plus/core/widgets/card_specialization.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/presentation/specialization/specialization_page.dart';

class AllSpecializationsPage extends StatefulWidget {
  const AllSpecializationsPage({super.key});

  @override
  _AllSpecializationsPageState createState() => _AllSpecializationsPageState();
}

class _AllSpecializationsPageState extends State<AllSpecializationsPage> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredSpecializations = [];

  @override
  void initState() {
    super.initState();
    filteredSpecializations = doctorSpecialties.skip(1).toList();
  }

  void filterSpecializations(String query) {
    setState(() {
      filteredSpecializations = doctorSpecialties
          .skip(1)
          .where((specialization) =>
              specialization.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBar(title: 'All Specializations'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterSpecializations,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: filteredSpecializations.isEmpty
                  ? const Center(child: Text('No results found'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: filteredSpecializations.length,
                      itemBuilder: (context, index) {
                        final specialization = filteredSpecializations[index];
                        return SpecializationCard(
                          title: specialization,
                          imagePath:
                              'assets/specializations/$specialization.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpecializationPage(
                                    specialization: specialization),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
