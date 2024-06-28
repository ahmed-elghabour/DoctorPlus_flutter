part of 'cancelled_appointments_cubit.dart';

sealed class CancelledAppointmentsState {}

final class CancelledAppointmentsInitial extends CancelledAppointmentsState {}

final class CancelledAppointmentsLoading extends CancelledAppointmentsState {}

final class CancelledAppointmentsLoaded extends CancelledAppointmentsState {
  final List<AppointmentModel> appointments;
  CancelledAppointmentsLoaded(this.appointments);
}

final class CancelledAppointmentsError extends CancelledAppointmentsState {
  final String message;
  CancelledAppointmentsError(this.message);
}
