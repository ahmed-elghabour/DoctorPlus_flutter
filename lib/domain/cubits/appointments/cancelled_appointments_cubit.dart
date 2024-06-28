import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
// import 'package:patient_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';

part 'cancelled_appointments_state.dart';

class CancelledAppointmentsCubit extends Cubit<CancelledAppointmentsState> {
  CancelledAppointmentsCubit() : super(CancelledAppointmentsInitial());

  void getPatientCancelledAppointments({required String patientId}) async {
    emit(CancelledAppointmentsLoading());
    try {
      List<AppointmentModel> patientPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getPatientCancelledAppointments(patientId);

      emit(CancelledAppointmentsLoaded(patientPendingAppointments));
    } catch (e) {
      emit(CancelledAppointmentsError(e.toString()));
    }
  }
}
