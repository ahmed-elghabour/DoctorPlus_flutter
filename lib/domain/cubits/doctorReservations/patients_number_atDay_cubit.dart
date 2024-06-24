import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_state.dart';
import 'package:doctor_plus/presentation/Doctor%20Home/utils/doctor_reservations_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsNumberAtDayCubit extends Cubit<PatientsNumAtDayState> {
  PatientsNumberAtDayCubit() : super(PatientsNumAtDayInitState());

   void fetchPatients(String doctorId){
    emit(PatientsNumAtDayPendingState());
    try {
      DoctorService.getPatientsNumAtDay(doctorId).listen((count) {
        emit(PatientsNumAtDayLoadedState(count));
      });
    } catch (e) {
      emit(PatientsNumAtDayFailedState(e.toString()));
    }
  }
}