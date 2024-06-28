import 'package:doctor_plus/domain/cubits/appointments/completed_appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';


class CompletedAppointmentsCubit extends Cubit<CompletedAppointmentsState> {
  CompletedAppointmentsCubit() : super(CompletedAppointmentsInitial());

  void getPatientCompletedAppointments({required String patientId}) async {
    emit(CompletedAppointmentsLoading());
    try {
      List<AppointmentModel> patientPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getPatientCompletedAppointments(patientId);

      emit(CompletedAppointmentsLoaded(patientPendingAppointments));
    } catch (e) {
      emit(CompletedAppointmentsError(e.toString()));
    }
  }
}
