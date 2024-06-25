part of 'completed_appointments_cubit.dart';

@immutable
sealed class CompletedAppointmentsState {}

final class CompletedAppointmentsInitial extends CompletedAppointmentsState {}

final class CompletedAppointmentsLoading extends CompletedAppointmentsState {}

final class CompletedAppointmentsLoaded extends CompletedAppointmentsState {
  final List<AppointmentModel> appointments;
  CompletedAppointmentsLoaded(this.appointments);
}

final class CompletedAppointmentsError extends CompletedAppointmentsState {
  final String message;
  CompletedAppointmentsError(this.message);
}
