import 'package:doctor_plus/data/data%20sources/patient_remote_data_source.dart';
import 'package:doctor_plus/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:equatable/equatable.dart';

part 'prefered_doctors_state.dart';

class PreferedDoctorsCubit extends Cubit<PreferedDoctorsState> {
  PreferedDoctorsCubit() : super(PreferedDoctorsInitial());

  void addPreferedDoctorToPatient(String patientId, Doctor doctor) async {
    try {
      await PatientRemoteDataSource()
          .addPreferedDoctorToPatient(patientId: patientId, doctor: doctor);
      emit(PreferedDoctorsAdded());
    } catch (e) {
      emit(PreferedDoctorsError(e.toString()));
    }
  }

  void removePreferedDoctorFromPatient(
      String patientId, String doctorId) async {
    try {
      await PatientRemoteDataSource().removePreferedDoctorFromPatient(
          doctorId: doctorId, patientId: patientId);
      emit(PreferedDoctorsRemoved());
    } catch (e) {
      emit(PreferedDoctorsError(e.toString()));
    }
  }

  void getPreferedDoctors(String patientId) async {
    emit(PreferedDoctorsLoading());
    try {
      List<Doctor> preferedDoctors =
          await PatientRepository(remoteDataSource: PatientRemoteDataSource())
              .getPreferedDoctors(patientId);
      emit(PreferedDoctorsLoaded(preferedDoctors));
    } catch (e) {
      emit(PreferedDoctorsError(e.toString()));
    }
  }
}
