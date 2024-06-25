import 'package:bloc/bloc.dart';
import 'package:doctor_plus/data/data%20sources/appointments_remote_data_source.dart';
// import 'package:doctor_plus/core/dummy/dummy_appointments.dart';
import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/repositories/appointments_repository.dart';
import 'package:meta/meta.dart';

part 'cancelled_appointments_state.dart';

class CancelledAppointmentsCubit extends Cubit<CancelledAppointmentsState> {
  CancelledAppointmentsCubit() : super(CancelledAppointmentsInitial());

  void getDoctorCancelledAppointments({required String doctorId}) async {
    emit(CancelledAppointmentsLoading());
    try {
      List<AppointmentModel> doctorPendingAppointments =
          await AppointmentsRepository(
                  remoteDataSource: AppointmentsRemoteDataSource())
              .getDoctorCancelledAppointments(doctorId);

      emit(CancelledAppointmentsLoaded(doctorPendingAppointments));
    } catch (e) {
      emit(CancelledAppointmentsError(e.toString()));
    }
  }
}
