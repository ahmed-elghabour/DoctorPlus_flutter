import 'package:doctor_plus/data/model/prescription.dart';
import 'package:doctor_plus/data/data%20sources/prescription_remote_data_source.dart';

class PrescriptionRepository {
  final PrescriptionRemoteDataSource remoteDataSource;
  PrescriptionRepository({required this.remoteDataSource});

  Future<List<Prescription>> getPrescriptions(String patientId) async {
    try {
      List<dynamic> reviews =
          await remoteDataSource.getPrescriptions(patientId);

      return reviews.map((e) => Prescription.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPrescription(Prescription prescription) async {
    try {
      await remoteDataSource.addPrescription(prescription);
    } catch (e) {
      rethrow;
    }
  }
}
