import 'package:doctor_plus/data/data%20sources/doctors_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';

class DoctorsRepository {
  final DoctorsRemoteDataSource remoteDataSource;
  DoctorsRepository({required this.remoteDataSource});

  Future<List<Doctor>> getRecommendedDoctors(String patientId) async {
    try {
      List<dynamic> doctors =
          await remoteDataSource.getRecommendedDoctors(patientId: patientId);
      return doctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Doctor>> getAllDoctors() async {
    try {
      List<dynamic> doctors = await remoteDataSource.getAllDoctors();
      return doctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      List<dynamic> doctors = await remoteDataSource.searchDoctors(query);
      return doctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
