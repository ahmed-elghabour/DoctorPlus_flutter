import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';

class AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;
  AppointmentsRepository({required this.remoteDataSource});

  Future<List<AppointmentModel>> getPatientUpcomingAppointments(
      String patientId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getPatientUpcomingAppointments(patientId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getPatientCompletedAppointments(
      String patientId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getPatientCompletedAppointments(patientId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getPatientCancelledAppointments(
      String patientId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getPatientCancelledAppointments(patientId);

      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
