part of 'upcoming_appointments_cubit.dart';

@immutable
sealed class UpcomingAppointmentsState {}

final class UpcomingAppointmentsInitial extends UpcomingAppointmentsState {}

final class UpcomingAppointmentsLoading extends UpcomingAppointmentsState {}

final class UpcomingAppointmentsLoaded extends UpcomingAppointmentsState {
  final List<AppointmentModel> appointments;
  UpcomingAppointmentsLoaded(this.appointments);
}

final class UpcomingAppointmentsError extends UpcomingAppointmentsState {
  final String message;
  UpcomingAppointmentsError(this.message);
}
