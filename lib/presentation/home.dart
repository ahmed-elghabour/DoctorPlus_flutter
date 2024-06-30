import 'package:doctor_plus/core/theming/styles.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_state.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/pages/doctor_home.dart';
import 'package:doctor_plus/presentation/patient%20home/pages/patient_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Doctor Plus',
          style: TextStyles.font24BlueBold,
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome to Doctor Plus',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoggedAndLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserLoggedAndLoadingSuccess) {
                if (state.user.type == "doctor") {
                  context
                      .read<DoctorReservationCubit>()
                      .fetchReservations(state.user.id);
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: state.user.type == "patient"
                      ? const PatientHome()
                      : const DoctorHome(),
                );
              } else if (state is UserLoggedAndLoadingFailure) {
                return const Text("Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
              } else {
                return const PatientHome();
              }
            },
          ),
        ],
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
                    navigate(context,
                        route:
                            context.read<UserCubit>().getUserType() == "patient"
                                ? Routes.profile
                                : Routes.doctorProfile);
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
