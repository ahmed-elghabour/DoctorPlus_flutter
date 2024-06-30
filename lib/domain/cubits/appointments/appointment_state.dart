import 'package:doctor_plus/data/model/appointment.dart';

sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> upcoming;
  final List<AppointmentModel> canceled;
  final List<AppointmentModel> completed;
  AppointmentsLoaded(this.upcoming, this.completed, this.canceled);
}

final class AppointmentsError extends AppointmentsState {
  final String message;
  AppointmentsError(this.message);
}
