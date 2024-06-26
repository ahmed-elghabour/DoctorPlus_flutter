import 'package:doctor_plus/data/data%20sources/doctors_remote_data_source.dart';
import 'package:doctor_plus/data/model/doctor.dart';
import 'package:doctor_plus/data/repositories/doctors_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommended_doctors_state.dart';

class RecommendedDoctorsCubit extends Cubit<RecommendedDoctorsState> {
  RecommendedDoctorsCubit() : super(RecommendedDoctorsInitial());

  void getRecommendedDocctors({required String patientId}) async {
    emit(RecommendedDoctorsLoading());
    try {
      List<Doctor> recommendedDoctors =
          await DoctorsRepository(remoteDataSource: DoctorsRemoteDataSource())
              .getRecommendedDoctors(patientId);

      emit(RecommendedDoctorsLoaded(recommendedDoctors));
    } catch (e) {
      emit(RecommendedDoctorsError(e.toString()));
    }
  }
}
