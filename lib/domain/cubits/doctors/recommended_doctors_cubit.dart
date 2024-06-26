import 'package:doctor_plus/data/data%20sources/doctors_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/repositories/doctors_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommended_doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial());

  void getRecommendedDocctors({required String patientId}) async {
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
      List<Doctor> allDoctors =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .getAllDoctors();

      emit(DoctorsLoaded(allDoctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  void searchDoctors(String query) async {
    emit(DoctorsLoading());
    try {
      List<Doctor> allDoctors =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .searchDoctors(query);

      emit(DoctorsLoaded(allDoctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }
}
