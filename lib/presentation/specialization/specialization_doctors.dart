import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class SpecializationDoctorCard extends StatelessWidget {
  final String name;
  final String speciality;
  final String? imageUrl;

  const SpecializationDoctorCard({
    Key? key,
    required this.name,
    required this.speciality,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.doctorProfile);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                  imageUrl ??
                      'https://cdn.pixabay.com/photo/2023/11/11/15/03/ai-generated-8381346_1280.jpg',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border_outlined),
                          onPressed: () {
                            // TODO: Add favorite button logic
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      speciality,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}