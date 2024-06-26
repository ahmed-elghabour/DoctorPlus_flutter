import 'package:doctor_plus/data/data%20sources/doctors_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/repositories/doctors_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommended_doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial()) {
    getAllDoctors();
    getRecommendedDoctors(patientId: '555');
  }
  List<Doctor> doctors = [];
  void getRecommendedDoctors({required String patientId}) async {
    emit(DoctorsLoading());
    try {
      List<Doctor> recommendedDoctors =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .getRecommendedDoctors(patientId);

      emit(DoctorsLoaded(recommendedDoctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  void getAllDoctors() async {
    emit(DoctorsLoading());
    try {
      doctors =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .getAllDoctors();

      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  void searchDoctors(String query) async {
    emit(DoctorsLoading());
    try {
      List<Doctor> docs = doctors
          .where((doctor) =>
              doctor.fName.toLowerCase().contains(query.toLowerCase()) ||
              doctor.lName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(DoctorsLoaded(docs));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  void getDoctorById({required String doctorId}) async {
    emit(FavoriteDoctorByIdLoading());
    try {
      Doctor? favoriteDoctor =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .getDoctorById(doctorId: doctorId);
      // if (preferedDoctor == null) {
      //   emit(PreferedDoctorByIdLoaded(null));
      // }
      emit(DoctorByIdLoaded(favoriteDoctor));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }
}
