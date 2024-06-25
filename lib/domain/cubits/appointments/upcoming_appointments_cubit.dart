import 'package:bloc/bloc.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/data%20sources/remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:flutter/material.dart';

part 'upcoming_appointments_state.dart';

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  UpcomingAppointmentsCubit() : super(UpcomingAppointmentsInitial());

  void getDoctorPendingAppointments({required String doctorId}) async {
    emit(UpcomingAppointmentsLoading());
    try {
      List<AppointmentModel> doctorPendingAppointments =
          await AppointmentsRepository(remoteDataSource: RemoteDataSource())
              .getDoctorPendingAppointments(doctorId);

      emit(UpcomingAppointmentsLoaded(doctorPendingAppointments));
    } catch (e) {
      emit(UpcomingAppointmentsError(e.toString()));
    }
  }
}
