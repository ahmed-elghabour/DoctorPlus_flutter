import 'package:doctor_plus/domain/cubits/doctorReservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/utils/reservation_sliders.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/carousel_slider.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/reservation_chunks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PatientsCarousel extends StatelessWidget {
  final String datePicked;
  const PatientsCarousel({super.key, required this.datePicked});

  @override
  Widget build(BuildContext context) {
    //TODO: Doctor ID
    context.read<DoctorReservationCubit>().fetchReservations("789", datePicked);
    return BlocBuilder<DoctorReservationCubit, List<dynamic>>(
      builder: (context, reservations) {
        if (reservations.isEmpty) {
          return const Center(child: Text("No patients at that day"));
        }
        List<List<dynamic>> chunkedReservations = chunkedReservList(reservations, 4);
        List<Widget> reservationSliders = getSliders(chunkedReservations, context);
        return PatientCarouselSlider(chunkedReservations: chunkedReservations, reservationSliders: reservationSliders);       
      }
    );
  }
}
