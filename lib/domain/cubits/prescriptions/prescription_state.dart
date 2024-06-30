import 'package:doctor_plus/data/model/prescription.dart';

sealed class PrescriptionState {}

class PrescriptionsInitial extends PrescriptionState {}

class PrescriptionsLoading extends PrescriptionState {}

class PrescriptionsLoaded extends PrescriptionState {
  List<Prescription> prescriptions;
  PrescriptionsLoaded(this.prescriptions);
}

class PrescriptionsError extends PrescriptionState {
  final String message;
  PrescriptionsError(this.message);
}
