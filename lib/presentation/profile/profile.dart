import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/data/model/patient.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';

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

  Future<void> getCurrentUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('patients')
        .doc(userId)
        .get();
    setState(() {
      // currentUser = snapshot.data() as Patient;
      print(userId);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    print(currentUser?.email);

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
                          name:
                              SharedPreference().getString(key: 'user.name') ??
                                  'No Name',
                        ),
                        EmailWidget(
                          email:
                              SharedPreference().getString(key: 'user.email') ??
                                  'No email',
                        ),
                        const SizedBox(height: 10),
                        const RowNavigatorWidget(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 19, horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 234, 242, 255),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(15),
                                    width: 60,
                                    child: Image.asset("assets/icons/id.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Personal Information",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 233, 250, 239),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(15),
                                    width: 60,
                                    child:
                                        Image.asset("assets/icons/tests.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "My Test & Diagnostic",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 238, 239),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(15),
                                    width: 60,
                                    child:
                                        Image.asset("assets/icons/payment.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Payment",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
                top: 60,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ProfileImage(
                    imageUrl: SharedPreference().getString(key: 'user.image'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class RowNavigatorWidget extends StatelessWidget {
  const RowNavigatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 248, 248, 248)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.doctorAppointments);
              },
              child: const Text(
                "My Appointment",
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ),
            const VerticalDivider(
              color: Colors.black26,
              width: 25,
              thickness: 1,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Medical Records",
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    required this.imageUrl,
  });
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          radius: 80,
          child: CircleAvatar(
            radius: 75,
            backgroundImage: imageUrl == null
                ? const AssetImage("assets/imgs/user_template.jpg")
                    as ImageProvider
                : NetworkImage(imageUrl!),
          ),
        ),
        // Edit Icon
        Positioned(
          bottom: 10,
          right: 0,
          child: CircleAvatar(
            radius: 19,
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            child: Image.asset(
              "assets/icons/edit.png",
              width: 18,
              height: 18,
            ),
          ),
        ),
      ],
    );
  }
}
