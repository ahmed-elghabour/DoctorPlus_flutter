import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/model/patient.dart';

class AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;
  AppointmentsRepository({required this.remoteDataSource});

  Future<List<AppointmentModel>> getPatientAppointments(
      String patientId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getPatientAppointments(patientId);
      return appointments
          .map((e) => AppointmentModel.fromJsonPatient(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getDoctorAppointments(String doctorId) async {
    try {
      List<dynamic> appointments =
          await remoteDataSource.getDoctorAppointments(doctorId);
      return appointments
          .map((e) => AppointmentModel.fromJsonDoctor(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Doctor>> getAppointmentedDoctors(List<String> doctors) async {
    try {
      List<dynamic> appointmentedDoctors =
          await remoteDataSource.getAppointmentedDoctors(doctors);
      return appointmentedDoctors.map((e) => Doctor.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Patient>> getAppointmentedPatients(List<String> patients) async {
    try {
      List<dynamic> appointmentedPatients =
          await remoteDataSource.getAppointmentedPatients(patients);
      return appointmentedPatients.map((e) => Patient.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  void deleteAppointment(AppointmentModel appointment) {
    try {
      remoteDataSource.deleteAppointment(appointment);
    } catch (e) {
      rethrow;
    }
  }

  void markAppointmentAsDone(AppointmentModel appointment) {
    try {
      remoteDataSource.markAppointmentAsDone(appointment);
    } catch (e) {
      rethrow;
    } 
  }
}
