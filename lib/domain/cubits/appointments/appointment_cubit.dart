import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentsState> {
  AppointmentCubit() : super(AppointmentsInitial());

  void getPatientCompletedAppointments({required String patientId}) async {
    emit(CompletedAppointmentsLoading());
    try {
      List<AppointmentModel> patientPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getPatientCompletedAppointments(patientId);

      emit(CompletedAppointmentsLoaded(patientPendingAppointments));
    } catch (e) {
      emit(CompletedAppointmentsError(e.toString()));
    }
  }

  void getPatientCancelledAppointments({required String patientId}) async {
    emit(CancelledAppointmentsLoading());
    try {
      List<AppointmentModel> patientPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getPatientCancelledAppointments(patientId);

      emit(CancelledAppointmentsLoaded(patientPendingAppointments));
    } catch (e) {
      emit(CancelledAppointmentsError(e.toString()));
    }
  }

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
