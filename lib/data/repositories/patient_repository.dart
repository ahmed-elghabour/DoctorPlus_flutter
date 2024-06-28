import 'package:doctor_plus/data/data%20sources/patient_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';

class PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepository({required this.remoteDataSource});

  Future<List<Doctor>> getFavoriteDoctors(String patientId) async {
    try {
      List<dynamic> favoriteDoctors =
          await remoteDataSource.getFavoriteDoctors(patientId);

      return favoriteDoctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor?> getFavoriteDoctorById(
      {required String doctorId, required String patientId}) async {
    try {
      final doctor = await remoteDataSource.getFavoriteDoctorById(
          doctorId: doctorId, patientId: patientId);
      if (doctor == null) return null;
      return Doctor.fromJson(doctor);
    } catch (e) {
      rethrow;
    }
  }
}
