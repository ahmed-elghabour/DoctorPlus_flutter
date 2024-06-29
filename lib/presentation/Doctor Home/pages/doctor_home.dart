import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/doctor_home_info_card.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/patient_list.dart';
import 'package:doctor_plus/utils/firebase.dart';
import 'package:doctor_plus/utils/functions.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FutureBuilder<String>(
          //   future: getDoctorName(),
          //   builder: (context, snapshot) {
          //     final String doctorName = snapshot.data ?? "";
          //     return RichText(
          //       text: TextSpan(
          //           text: getGreeting(),
          //           style: const TextStyle(fontSize: 15, color: Colors.black),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '$doctorName !',
          //                 style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 18,
          //                     color: Color(0xFF3E36B0)))
          //           ]),
          //     );
          //   },
          // ),
          RichText(
            text: TextSpan(
                text: getGreeting(),
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'Dr: ${context.read<UserCubit>().user?.fName ?? 'Null'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF3E36B0)))
                ]),
          ),
          const DoctorHomeCard(),
          const SizedBox(
            height: 20,
          ),
          const PatientList()
        ],
      ),
    );
  }

  Future<String> getDoctorName() async {
    var data = await CustomFirebase()
        .getDocumentData(docID: SharedPreference().getString(key: "userID")!);
    return data['fName'];
  }
}
