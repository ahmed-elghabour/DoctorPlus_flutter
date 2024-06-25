import 'package:doctor_plus/data/data%20sources/remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';

class AppointmentsRepository {
  final RemoteDataSource remoteDataSource;
  AppointmentsRepository({required this.remoteDataSource});

  Future<List<AppointmentModel>> getDoctorPendingAppointments(
      String doctorId) async {
    List<dynamic> appointments =
        await remoteDataSource.getDoctorPendingAppointments(doctorId);

    return appointments.map((e) => AppointmentModel.fromJson(e)).toList();
  }
}
