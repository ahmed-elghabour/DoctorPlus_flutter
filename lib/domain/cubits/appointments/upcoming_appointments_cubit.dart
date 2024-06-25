import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:flutter/material.dart';

part 'upcoming_appointments_state.dart';

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  UpcomingAppointmentsCubit() : super(UpcomingAppointmentsInitial());

  void getPatientUpcomingAppointments({required String patientId}) async {
    emit(UpcomingAppointmentsLoading());
    try {
      List<AppointmentModel> patientPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getPatientUpcomingAppointments(patientId);

      emit(UpcomingAppointmentsLoaded(patientPendingAppointments));
    } catch (e) {
      emit(UpcomingAppointmentsError(e.toString()));
    }
  }

  void cancelPatientUpcomingAppointment(
      {required String appointmentId, required String patientId}) async {
    emit(UpcomingAppointmentsLoading());
    try {
      await AppointmentsRemoteDataSource()
          .cancelPatientUpcomingAppointment(appointmentId, patientId);
    } catch (e) {
      emit(UpcomingAppointmentsError(e.toString()));
    }
  }
}
