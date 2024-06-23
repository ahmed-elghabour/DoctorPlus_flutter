import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/presentation/widgets/card_specialization.dart';
import 'package:doctor_plus/presentation/widgets/card_doctor.dart';
import 'package:doctor_plus/presentation/pages/complaints.dart';
import 'package:doctor_plus/utils/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /*
  Future<String> _getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.get('username');
    }
    return 'Ahmed';
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/appIcon.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text('Doctor Plus'),
          ],
        ),
        actions: [
          FutureBuilder<User?>(
            future: Future.value(FirebaseAuth.instance.currentUser),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return IconButton(
                  icon: const Icon(Icons.person_sharp),
                  onPressed: () {
                    navigate(context, route: Routes.profile);
                  },
                );
              } else {
                return TextButton(
                  onPressed: () {
                    navigate(context, route: Routes.login);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }
            },
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      /*
      body: FutureBuilder<String>(
        future: _getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String username = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
      */
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Doctor Plus',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('How are you today?'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_hospital,
                            color: Colors.white, size: 48),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Book and schedule with nearest doctor',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle the navigation
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: const Text(
                                  'Find Nearby',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Doctor Speciality',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SpecializationCard(
                            title: 'General', icon: Icons.local_hospital),
                        SpecializationCard(
                            title: 'Neurologic',
                            icon: Icons.face_retouching_natural_rounded),
                        SpecializationCard(
                            title: 'Pediatric', icon: Icons.child_care),
                        SpecializationCard(
                            title: 'Radiology', icon: Icons.radio),
                        // Add more specialities as needed
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Recommendation Doctor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const DoctorCard(
                      name: 'Dr. Randy Wigham',
                      speciality: 'General | RSUD Gatot Subroto',
                      rating: 4.8,
                      reviews: 4279),
                  const DoctorCard(
                      name: 'Dr. Cullan Sullivan',
                      speciality: 'Cardiologist | RSUD Soetomo',
                      rating: 4.7,
                      reviews: 3241),
                  const DoctorCard(
                      name: 'Dr. Cullan Sullivan',
                      speciality: 'Cardiologist | RSUD Soetomo',
                      rating: 4.7,
                      reviews: 3241),
                  const DoctorCard(
                      name: 'Dr. Cullan Sullivan',
                      speciality: 'Cardiologist | RSUD Soetomo',
                      rating: 4.7,
                      reviews: 3241),
                  const DoctorCard(
                      name: 'Dr. Cullan Sullivan',
                      speciality: 'Cardiologist | RSUD Soetomo',
                      rating: 4.7,
                      reviews: 3241),
                  // Add more doctors as needed
                  // Footer
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      children: [
                        Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Doctor Plus is a healthcare management app designed to streamline interactions between doctors, patients, and administrators. The app features user-friendly interfaces for sign-up, login, profile management, reservations, notifications, and more.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Complaints',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              navigate(context, route: Routes.home);
              break;
            case 1:
              //TODO: add route
              // navigate(context, route: '/favorites');
              break;
            case 2:
              //TODO: add route
              // navigate(context, route: '/search');
              break;
            case 3:
              //TODO: add route
              //navigate(context, route: '/notifications');
              break;
            case 4:
              navigate(context, route: Routes.complaint);
              break;
          }
        },
      ),
    );
  }

  void navigate(BuildContext context, {required String route}) {
    Navigator.pushNamed(context, route);
  }
}
