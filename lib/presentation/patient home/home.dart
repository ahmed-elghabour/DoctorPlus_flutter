import 'package:doctor_plus/core/theming/styles.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/pages/doctor_home.dart';
import 'package:doctor_plus/presentation/patient%20home/all_doctors.dart';
import 'package:doctor_plus/presentation/patient%20home/all_specializations.dart';
import 'package:doctor_plus/presentation/patient%20home/patient_home.dart';
import 'package:doctor_plus/presentation/specialization/specialization_page.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_plus/core/widgets/card_specialization.dart';
import 'package:doctor_plus/core/widgets/card_doctor.dart';
import 'package:doctor_plus/data/demo.dart';
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
        title: Text(
          'Doctor Plus',
          style: TextStyles.font24BlueBold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Doctor Plus',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SharedPreference().getString(key: "userType") == "doctor"? const DoctorHome() : const PatientHome()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FutureBuilder<User?>(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, snapshot) {
          bool isLoggedIn = snapshot.hasData && snapshot.data != null;

          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.comment),
                label: 'Complaints',
              ),
              BottomNavigationBarItem(
                icon: Icon(isLoggedIn ? Icons.person_rounded : Icons.login),
                label: isLoggedIn ? 'Profile' : 'Login',
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
                  // TODO: Add route for Favorites
                  // navigate(context, route: '/favorites');
                  break;
                case 2:
                  navigate(context, route: '/search');
                  break;
                case 3:
                  navigate(context, route: Routes.complaint);
                  break;
                case 4:
                  if (isLoggedIn) {
                    navigate(context, route: Routes.profile);
                  } else {
                    navigate(context, route: Routes.login);
                  }
                  break;
              }
            },
          );
        },
      ),
    );
  }

  void navigate(BuildContext context, {required String route}) {
    Navigator.pushNamed(context, route);
  }

}
