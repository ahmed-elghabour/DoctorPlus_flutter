import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/core/widgets/card_specialization.dart';
import 'package:doctor_plus/data/demo.dart';
import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:doctor_plus/presentation/patient%20home/pages/all_doctors.dart';
import 'package:doctor_plus/presentation/patient%20home/pages/all_specializations.dart';
import 'package:doctor_plus/presentation/specialization/specialization_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientHome extends StatelessWidget {
  const PatientHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // FilterByLocation(),
        SizedBox(height: 8),
        AllSpecializations(),
        SizedBox(height: 8),
        RecommendationDoctors(),
      ],
    );
  }
}

class AllSpecializations extends StatelessWidget {
  const AllSpecializations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Doctor Speciality',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllSpecializationsPage()),
                );
              },
              child: const Text('See More'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: doctorSpecialties.skip(1).map((specialization) {
              return SizedBox(
                width: 150,
                height: 115,
                child: SpecializationCard(
                  title: specialization,
                  imagePath: 'assets/specializations/$specialization.png',
                  onTap: () {
                    navigateToSpecialization(context, specialization);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void navigateToSpecialization(BuildContext context, String specialization) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SpecializationPage(specialization: specialization),
      ),
    );
  }
}

class RecommendationDoctors extends StatelessWidget {
  const RecommendationDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommendation Doctor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllDoctorsPage()),
                );
              },
              child: const Text('See More'),
            ),
          ],
        ),
        BlocBuilder<DoctorsCubit, DoctorsState>(
          builder: (context, state) {
            if (state is DoctorsLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      3,
                      (index) => DoctorCard(
                            doctor: state.doctors[index],
                          )),
                ),
              );
              // return ListView.builder(
              //     itemBuilder: (context, index) {
              //       return DoctorCard(
              //         doctor: state.doctors[index],
              //       );
              //     },
              //     itemCount: state.doctors.length);
            } else if (state is DoctorsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Errorr loading doctors"),
              );
            }
          },
        ),
      ],
    );
  }
}

class FilterByLocation extends StatelessWidget {
  const FilterByLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_hospital, color: Colors.white, size: 48),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Book with nearest doctor',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Handle the navigation
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  'Find Nearby',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
