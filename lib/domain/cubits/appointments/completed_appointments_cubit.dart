import 'package:bloc/bloc.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:meta/meta.dart';

part 'completed_appointments_state.dart';

class CompletedAppointmentsCubit extends Cubit<CompletedAppointmentsState> {
  CompletedAppointmentsCubit() : super(CompletedAppointmentsInitial());

  void getDoctorCompletedAppointments({required String doctorId}) async {
    emit(CompletedAppointmentsLoading());
    try {
      List<AppointmentModel> doctorPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getDoctorCompletedAppointments(doctorId);

      emit(CompletedAppointmentsLoaded(doctorPendingAppointments));
    } catch (e) {
      emit(CompletedAppointmentsError(e.toString()));
    }
  }
}
