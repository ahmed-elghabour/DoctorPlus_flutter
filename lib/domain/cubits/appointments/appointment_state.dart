import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/doctor.dart';

sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> upcoming;
  final List<AppointmentModel> canceled;
  final List<AppointmentModel> completed;
  final List<Doctor> doctors;
  AppointmentsLoaded(
      this.upcoming, this.completed, this.canceled, this.doctors);
}

final class AppointmentsError extends AppointmentsState {
  final String message;
  AppointmentsError(this.message);
}
