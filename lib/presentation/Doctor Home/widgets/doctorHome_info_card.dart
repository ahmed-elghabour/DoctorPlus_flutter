import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class doctorHomeCard extends StatefulWidget {
  const doctorHomeCard({super.key});

  @override
  State<doctorHomeCard> createState() => _doctorHomeCardState();
}

class _doctorHomeCardState extends State<doctorHomeCard> {
  final int newPatients = 40;
  final int oldPatients = 64;
  @override
  Widget build(BuildContext context) {
    context.read<PatientsNumberAtDayCubit>().fetchPatients("764");
    return BlocBuilder<PatientsNumberAtDayCubit, PatientsNumAtDayState>(
      builder: (context, state) {
        int patientsNumber = 0;
        
        if(state is PatientsNumAtDayPendingState){
          return const CircularProgressIndicator();
        }

        if(state is PatientsNumAtDayLoadedState) {
          patientsNumber = state.patientsNumber;
        }

        if(state is PatientsNumAtDayFailedState) {
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
            padding: const EdgeInsets.all(10.0),
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
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 191, 230, 248),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'New patients',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$newPatients',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 120,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 191, 230, 248),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Old patients',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$oldPatients',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
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
