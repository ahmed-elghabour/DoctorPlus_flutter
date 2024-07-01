import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentsState> {
  AppointmentCubit() : super(AppointmentsInitial());
  List<Doctor> doctors = [];
  late List<AppointmentModel> appointments;
  List<AppointmentModel> upcoming = [], canceled = [], completed = [];
  void getPatientAppointments({required String patientId}) async {
    emit(AppointmentsLoading());
    try {
      appointments = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getPatientAppointments(patientId);
      List<String> doctorsID = appointments.map((e) => e.doctorId).toList();
      doctors = await AppointmentsRepository(
              remoteDataSource: AppointmentsRemoteDataSource())
          .getAppointmentedDoctors(doctorsID);
      filterAppointments();
      emit(AppointmentsLoaded(upcoming, completed, canceled, doctors));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  filterAppointments() {
    for (var appointment in appointments) {
      if (appointment.status == 'upcoming') {
        upcoming.add(appointment);
      } else if (appointment.status == 'completed') {
        completed.add(appointment);
      } else {
        canceled.add(appointment);
      }
    }
  }

  void deleteAppointment(AppointmentModel appointment) {
    emit(AppointmentsLoading());
    try {
      AppointmentsRepository(remoteDataSource: AppointmentsRemoteDataSource())
          .deleteAppointment(appointment);
      appointments.remove(appointment);
      filterAppointments();
      emit(AppointmentsLoaded(upcoming, completed, canceled, doctors));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  markAppointmentAsDone(AppointmentModel appointment) {
    emit(AppointmentsLoading());
    print("Appointment done - Fun ");
    print("Appointment done - ID: ${appointment.id}");
    try {
      print("Appointment done - ID: ${appointment.id}");
      print("Appointment done - Patient: ${appointment.patientId}");
      print("Appointment done - Doctor: ${appointment.doctorId}");
      AppointmentsRepository(remoteDataSource: AppointmentsRemoteDataSource())
          .markAppointmentAsDone(appointment);
      appointments.remove(appointment);
      filterAppointments();
      emit(AppointmentsLoaded(upcoming, completed, canceled, doctors));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }
}
