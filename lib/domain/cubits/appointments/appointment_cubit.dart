import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentsState> {
  AppointmentCubit() : super(AppointmentsInitial());

  void getPatientAppointments({required String patientId}) async {
    emit(AppointmentsLoading());
    try {
      List<AppointmentModel> appointments = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getPatientAppointments(patientId);
      List<String> doctorsID = appointments.map((e) => e.doctorId).toList();
      List<Doctor> doctors = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getAppointmentedDoctors(doctorsID);

      List<AppointmentModel> upcoming = [];
      List<AppointmentModel> canceled = [];
      List<AppointmentModel> completed = [];

      for (var appointment in appointments) {
        if (appointment.status == 'upcoming') {
          upcoming.add(appointment);
        } else if (appointment.status == 'completed') {
          completed.add(appointment);
        } else {
          canceled.add(appointment);
        }
      }
      emit(AppointmentsLoaded(upcoming, completed, canceled, doctors));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }
}
