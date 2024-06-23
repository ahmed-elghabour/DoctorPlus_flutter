import 'package:bloc/bloc.dart';
import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:meta/meta.dart';

part 'cancelled_appointments_state.dart';

class CancelledAppointmentsCubit extends Cubit<CancelledAppointmentsState> {
  CancelledAppointmentsCubit() : super(CancelledAppointmentsInitial());

  void getCancelledAppointments() {
    emit(CancelledAppointmentsLoading());
    try {
      final List<Appointment> appointments =
          dummyAppointments.where((appointment) {
        return appointment.status == AppointmentStatus.cancelled;
      }).toList();
      emit(CancelledAppointmentsLoaded(appointments));
    } catch (e) {
      emit(CancelledAppointmentsError(e.toString()));
    }
  }
}
