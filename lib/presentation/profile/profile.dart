import 'package:doctor_plus/core/widgets/appbar_icon.dart';
import 'package:doctor_plus/core/widgets/custom_app_bar.dart';
import 'package:doctor_plus/core/widgets/image_picker.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void navigate({required String route}) => Navigator.pushNamed(context, route);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 36, 124, 255),
        appBar: MyCustomAppBar(
          isDefault: false,
          title: 'My Appointments',
          actions: [
            appBarIcon(
              isDefault: false,
              iconSize: 30,
              icon: Icons.settings,
              onTap: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned.fill(
                  top: -70,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CustomImagePicker(
                      imageSize: 70,
                      icon: Icons.edit,
                      frameColor: Colors.white,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      "A.Rahman Khallaf",
                      style: _buildTextStyle(
                        size: 25,
                        color: Colors.black87,
                        weight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "a.rahman@gmail.com",
                      style: _buildTextStyle(
                        size: 18,
                        color: Colors.black45,
                      ),
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
                                    borderRadius: BorderRadius.circular(20)),
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
                                    fontSize: 19, fontWeight: FontWeight.w400),
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
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(15),
                                width: 60,
                                child: Image.asset("assets/icons/tests.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "My Test & Diagnostic",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w400),
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
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(15),
                                width: 60,
                                child: Image.asset("assets/icons/payment.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Payment",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ],
            ),
          ),
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
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.doctorAppointments),
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

TextStyle _buildTextStyle(
    {required Color color, required double size, FontWeight? weight}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
  );
}

// class ProfileImage extends StatelessWidget {
//   const ProfileImage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const CircleAvatar(
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           radius: 80,
//           child: CircleAvatar(
//             radius: 75,
//             backgroundImage: NetworkImage(
//                 "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg"),
//           ),
//         ),
//         // Edit Icon
//         Positioned(
//           bottom: 10,
//           right: 0,
//           child: CircleAvatar(
//             radius: 19,
//             backgroundColor: const Color.fromARGB(255, 248, 248, 248),
//             child: Image.asset(
//               "assets/icons/edit.png",
//               width: 18,
//               height: 18,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
