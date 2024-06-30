import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_state.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/patients_number_at_day_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/patients_number_at_day_state.dart';
import 'package:doctor_plus/presentation/Doctor%20home/widgets/new_patients_box.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHomeCard extends StatelessWidget {
  const DoctorHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorReservationCubit, DoctorReservationState>(
      builder: (context, state) {
        if (state is DoctorReservationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorReservationLoaded) {
          print("loaded");
          print("loaded - Old: ${state.old}");
          print("loaded - Current: ${state.current}");
          print("loaded - NewP: ${state.newP}");
          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 170,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(2.5, 1),
                  colors: <Color>[
                    Color(0xFFA6DEF7),
                    Color(0xFF3E36B0),
                  ],
                  tileMode: TileMode.clamp,
                ),
                image: DecorationImage(
                    image: AssetImage('assets/DoctorEquipment.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.centerRight),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Visits for today',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${state.current}',
                    style: const TextStyle(
                        fontSize: 29,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        PatientsBox(
                          patients: state.newP,
                          patientType: "New Patients",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PatientsBox(
                          patients: state.old,
                          patientType: "Old Patients",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is DoctorReservationError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
