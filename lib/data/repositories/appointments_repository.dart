import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';

class AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;
  AppointmentsRepository({required this.remoteDataSource});

  Future<List<AppointmentModel>> getDoctorUpcomingAppointments(
      String doctorId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getDoctorUpcomingAppointments(doctorId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getDoctorCompletedAppointments(
      String doctorId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getDoctorCompletedAppointments(doctorId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getDoctorCancelledAppointments(
      String doctorId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getDoctorCancelledAppointments(doctorId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
