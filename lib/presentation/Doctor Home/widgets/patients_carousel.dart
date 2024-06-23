import 'package:doctor_plus/data/model/doctor_reservation.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/reservation_sliders.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/reservation_chunks.dart';
import 'package:doctor_plus/presentation/doctor%20home/widgets/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PatientsCarousel extends StatelessWidget {
  const PatientsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorReservationCubit, List<DoctorReservation>>(
      builder: (context, reservations) {
        if (reservations.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        List<List<DoctorReservation>> chunkedReservations = chunkedReservList(reservations, 4);
        List<Widget> reservationSliders = getSliders(chunkedReservations);
        return PatientCarouselSlider(chunkedReservations: chunkedReservations, reservationSliders: reservationSliders);       
      }
    );
  }
}
