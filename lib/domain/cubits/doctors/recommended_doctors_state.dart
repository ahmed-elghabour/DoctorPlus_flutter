part of 'recommended_doctors_cubit.dart';

sealed class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

final class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<Doctor> doctors;
  const DoctorsLoaded(this.doctors);
}

class DoctorsError extends DoctorsState {
  final String message;
  const DoctorsError(this.message);
}

///////
class FavoriteDoctorByIdLoading extends DoctorsState {}

class DoctorByIdLoaded extends DoctorsState {
  final Doctor? favoriteDoctor;
  const DoctorByIdLoaded(this.favoriteDoctor);
}

class DoctorByIdError extends DoctorsState {
  final String message;
  const DoctorByIdError(this.message);
}
