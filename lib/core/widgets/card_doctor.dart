import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String speciality;
  final double rating;
  final int reviews;

  const DoctorCard({
    super.key,
    required this.name,
    required this.speciality,
    required this.rating,
    required this.reviews,
  });

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
              const CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2023/11/11/15/03/ai-generated-8381346_1280.jpg'),
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
                            //  TODO  Add favorite button logic
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      speciality,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '$rating ($reviews reviews)',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
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
