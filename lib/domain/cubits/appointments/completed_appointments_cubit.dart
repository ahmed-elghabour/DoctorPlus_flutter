import 'package:bloc/bloc.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:meta/meta.dart';

part 'completed_appointments_state.dart';

class CompletedAppointmentsCubit extends Cubit<CompletedAppointmentsState> {
  CompletedAppointmentsCubit() : super(CompletedAppointmentsInitial());

  void getCompletedAppointments() {
    emit(CompletedAppointmentsLoading());
    try {
      // final List<AppointmentModel> appointments =
      //     dummyAppointments.where((appointment) {
      //   return appointment.status == AppointmentStatus.done;
      // }).toList();
      // emit(CompletedAppointmentsLoaded(appointments));
    } catch (e) {
      emit(CompletedAppointmentsError(e.toString()));
    }
  }
}
