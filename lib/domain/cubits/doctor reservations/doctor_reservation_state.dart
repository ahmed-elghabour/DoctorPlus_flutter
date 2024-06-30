import 'package:doctor_plus/data/model/appointment.dart';
import 'package:doctor_plus/data/model/patient.dart';

sealed class DoctorReservationState {}

final class DoctorReservationInitial extends DoctorReservationState {}

final class DoctorReservationLoading extends DoctorReservationState {}

final class DoctorReservationLoaded extends DoctorReservationState {
  final List<AppointmentModel> appointments;
  final List<Patient> patients;
  final int current, old, newP;
  DoctorReservationLoaded(
    this.appointments,
    this.current,
    this.old,
    this.newP,
    this.patients,
  );
}

final class DoctorReservationError extends DoctorReservationState {
  final String message;
  DoctorReservationError(this.message);
}
