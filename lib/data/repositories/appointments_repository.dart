import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';

class AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;
  AppointmentsRepository({required this.remoteDataSource});

  Future<List<AppointmentModel>> getPatientAppointments(
      String patientId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getPatientAppointments(patientId);
      return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
