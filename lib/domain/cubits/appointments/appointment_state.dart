import 'package:doctor_plus/data/model/appointment.dart';

sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}

final class CancelledAppointmentsLoading extends AppointmentsState {}

final class CompletedAppointmentsLoading extends AppointmentsState {}

final class UpcomingAppointmentsLoading extends AppointmentsState {}

final class CancelledAppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;
  CancelledAppointmentsLoaded(this.appointments);
}

final class CompletedAppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;
  CompletedAppointmentsLoaded(this.appointments);
}

final class UpcomingAppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;
  UpcomingAppointmentsLoaded(this.appointments);
}

final class CancelledAppointmentsError extends AppointmentsState {
  final String message;
  CancelledAppointmentsError(this.message);
}

final class CompletedAppointmentsError extends AppointmentsState {
  final String message;
  CompletedAppointmentsError(this.message);
}

final class UpcomingAppointmentsError extends AppointmentsState {
  final String message;
  UpcomingAppointmentsError(this.message);
}
