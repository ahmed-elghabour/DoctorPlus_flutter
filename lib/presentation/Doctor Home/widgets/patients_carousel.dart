import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_state.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/utils/reservation_sliders.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/widgets/carousel_slider.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/reservation_chunks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsCarousel extends StatelessWidget {
  const PatientsCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorReservationCubit, DoctorReservationState>(
        builder: (context, state) {
      if (state is DoctorReservationLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DoctorReservationLoaded) {
        List<List<dynamic>> chunkedReservations =
            chunkedReservList(state.appointments, 4);
        List<Widget> reservationSliders =
            getSliders(chunkedReservations, state.patients, context);

        return PatientCarouselSlider(
            chunkedReservations: chunkedReservations,
            reservationSliders: reservationSliders);
      } else {
        return const Text("Doctor Reservation Loaded");
        // return PatientCarouselSlider(chunkedReservations: [], reservationSliders: []);
      }
    });
  }
}
