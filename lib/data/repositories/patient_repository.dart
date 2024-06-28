import 'package:doctor_plus/data/data%20sources/patient_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';

class PatientRepository {
  final PatientRemoteDataSource remoteDataSource;

  PatientRepository({required this.remoteDataSource});

  Future<List<Doctor>> getPreferedDoctors(String patientId) async {
    try {
      List<dynamic> preferedDoctors =
          await remoteDataSource.getPreferedDoctors(patientId);

      return preferedDoctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Doctor?> getPreferedDoctorById(
      {required String doctorId, required String patientId}) async {
    try {
      final doctor = await remoteDataSource.getPreferedDoctorById(
          doctorId: doctorId, patientId: patientId);
      if (doctor == null) return null;
      return Doctor.fromJson(doctor);
    } catch (e) {
      rethrow;
    }
  }
}
