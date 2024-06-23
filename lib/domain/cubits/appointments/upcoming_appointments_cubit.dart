import 'package:bloc/bloc.dart';
import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:flutter/material.dart';

part 'upcoming_appointments_state.dart';

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  UpcomingAppointmentsCubit() : super(UpcomingAppointmentsInitial());

  void getUpcomingAppointments() {
    emit(UpcomingAppointmentsLoading());
    try {
      final List<Appointment> appointments =
          dummyAppointments.where((appointment) {
        return appointment.status == AppointmentStatus.pending ||
            appointment.status == AppointmentStatus.rescheduled;
      }).toList();
      emit(UpcomingAppointmentsLoaded(appointments));
    } catch (e) {
      emit(UpcomingAppointmentsError(e.toString()));
    }
  }
}
