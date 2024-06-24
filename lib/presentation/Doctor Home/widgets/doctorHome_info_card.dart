import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_state.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/new_patients_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHomeCard extends StatelessWidget {
  final int oldPatients = 64;

  const DoctorHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PatientsNumberAtDayCubit>().fetchPatients("764");
    return BlocBuilder<PatientsNumberAtDayCubit, PatientsNumAtDayState>(
      builder: (context, state) {
        int patientsNumber = 0;

        if (state is PatientsNumAtDayPendingState) {
          return const CircularProgressIndicator();
        }

        if (state is PatientsNumAtDayLoadedState) {
          patientsNumber = state.patientsNumber;
        }

        if (state is PatientsNumAtDayFailedState) {
          return Center(child: Text(state.message));
        }
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
                  '$patientsNumber',
                  style: const TextStyle(
                      fontSize: 29,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Expanded(
                  child: Row(
                    children: [
                      PatientsBox(
                        patients: 40,
                        patientType: "New Patient",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      PatientsBox(
                        patients: 64,
                        patientType: "Old Patient",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
