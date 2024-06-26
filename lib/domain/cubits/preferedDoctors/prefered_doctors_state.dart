part of 'prefered_doctors_cubit.dart';

sealed class PreferedDoctorsState extends Equatable {
  const PreferedDoctorsState();

  @override
  List<Object> get props => [];
}

final class PreferedDoctorsInitial extends PreferedDoctorsState {}

final class PreferedDoctorsAdded extends PreferedDoctorsState {}

final class PreferedDoctorsRemoved extends PreferedDoctorsState {}

final class PreferedDoctorsLoading extends PreferedDoctorsState {}

final class PreferedDoctorsLoaded extends PreferedDoctorsState {
  final List<Doctor> preferedDoctors;
  const PreferedDoctorsLoaded(this.preferedDoctors);
}

final class PreferedDoctorsError extends PreferedDoctorsState {
  final String message;
  const PreferedDoctorsError(this.message);
}
