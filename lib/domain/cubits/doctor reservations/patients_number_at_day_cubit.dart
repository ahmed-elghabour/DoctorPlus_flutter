import 'package:doctor_plus/domain/cubits/doctor%20reservations/patients_number_at_day_state.dart';
import 'package:doctor_plus/presentation/doctor%20home/utils/doctor_reservations_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsNumberAtDayCubit extends Cubit<PatientsNumAtDayState> {
  PatientsNumberAtDayCubit() : super(PatientsNumAtDayInitState());

  void fetchPatients(String? doctorId) {
    emit(PatientsNumAtDayPendingState());
    try {
      DoctorService.getPatientsNumAtDay(doctorId!).listen((data) {
        emit(PatientsNumAtDayLoadedState(data));
      });
    } catch (e) {
      emit(PatientsNumAtDayFailedState(e.toString()));
    }
  }
}
