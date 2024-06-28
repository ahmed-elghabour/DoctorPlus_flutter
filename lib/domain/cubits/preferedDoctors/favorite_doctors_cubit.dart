import 'package:doctor_plus/data/data%20sources/patient_remote_data_source.dart';
import 'package:doctor_plus/data/repositories/patient_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:equatable/equatable.dart';

part 'favorite_doctors_state.dart';

class FavoriteDoctorsCubit extends Cubit<FavoriteDoctorsState> {
  FavoriteDoctorsCubit() : super(FavoriteDoctorsInitial());

  void addFavoriteDoctorToPatient(
      {required String patientId, required Doctor doctor}) async {
    try {
      await PatientRemoteDataSource()
          .addFavoriteDoctorToPatient(patientId: patientId, doctor: doctor);
      emit(FavoriteDoctorsAdded());
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  void removeFavoriteDoctorFromPatient(
      {required String doctorId, required String patientId}) async {
    try {
      await PatientRemoteDataSource().removeFavoriteDoctorFromPatient(
          doctorId: doctorId, patientId: patientId);
      emit(FavoriteDoctorsRemoved());
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  void getFavoriteDoctors(String patientId) async {
    emit(FavoriteDoctorsLoading());
    try {
      List<Doctor> favoriteDoctors =
          await PatientRepository(remoteDataSource: PatientRemoteDataSource())
              .getFavoriteDoctors(patientId);
      emit(FavoriteDoctorsLoaded(favoriteDoctors));
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }

  void getFavoriteDoctorById(
      {required String doctorId, required String patientId}) async {
    emit(FavoriteDoctorByIdLoading());
    try {
      Doctor? FavoriteDoctor =
          await PatientRepository(remoteDataSource: PatientRemoteDataSource())
              .getFavoriteDoctorById(doctorId: doctorId, patientId: patientId);
      // if (FavoriteDoctor == null) {
      //   emit(FavoriteDoctorByIdLoaded(null));
      // }
      emit(FavoriteDoctorByIdLoaded(FavoriteDoctor));
    } catch (e) {
      emit(FavoriteDoctorsError(e.toString()));
    }
  }
}
