import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/Profile%20Preview/pages/profile_preview.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void navigate({required String route}) => Navigator.pushNamed(context, route);
  String? userId = SharedPreference().getString(key: "userID");

  Patient? currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Patient patient = context.read<UserCubit>().getUser();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 124, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {
                navigate(route: Routes.settings);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 90),
                        NameWidget(
                          name: '${patient.fName} ${patient.lName}',
                        ),
                        EmailWidget(email: patient.email),
                        const SizedBox(height: 10),
                        //  const RowNavigatorWidget(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 19, horizontal: 20),
                          child: Column(
                            children: [
                              RowNavigatorWidget(
                                image: "id",
                                title: "My Appointments",
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.doctorAppointments,
                                ),
                              ),
                              RowNavigatorWidget(
                                image: "tests",
                                title: "Medical History",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientPreview(
                                      patient: patient,
                                    ),
                                  ),
                                ),
                              ),
                              RowNavigatorWidget(
                                image: "payment",
                                title: "Payment",
                                onTap: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Positioned.fill(
                top: 60,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ProfileImage(),
                ))
          ],
        ),
      ),
    );
  }
}

class TopProfilePreview {
  TopProfilePreview();
}

class RowNavigatorWidget extends StatelessWidget {
  final String title;
  final String image;
  final void Function() onTap;
  const RowNavigatorWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 242, 255),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(15),
                width: 60,
                child: Image.asset("assets/icons/$image.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}
// class RowNavigatorWidget extends StatelessWidget {
//   const RowNavigatorWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: const Color.fromARGB(255, 248, 248, 248)),
//       child: IntrinsicHeight(
//         child:
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.doctorAppointments);
//               },
//               child: const Text(
//                 "My Appointment",
//                 style: TextStyle(color: Colors.black54, fontSize: 17),
//               ),
//             ),
//             const VerticalDivider(
//               color: Colors.black26,
//               width: 25,
//               thickness: 1,
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 "Medical Records",
//                 style: TextStyle(color: Colors.black54, fontSize: 17),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        email,
        style: const TextStyle(fontSize: 18, color: Colors.black45),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      radius: 80,
      child: CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage("assets/imgs/patient.jpg"),
      ),
    );
  }
}
