part of 'favorite_doctors_cubit.dart';

sealed class FavoriteDoctorsState extends Equatable {
  const FavoriteDoctorsState();

  @override
  List<Object> get props => [];
}

final class FavoriteDoctorsInitial extends FavoriteDoctorsState {}

/////////
final class FavoriteDoctorsAdded extends FavoriteDoctorsState {}

final class FavoriteDoctorsRemoved extends FavoriteDoctorsState {}

/////////
final class FavoriteDoctorsLoading extends FavoriteDoctorsState {}

final class FavoriteDoctorsLoaded extends FavoriteDoctorsState {
  final List<Doctor> favoritedDoctors;
  const FavoriteDoctorsLoaded(this.favoritedDoctors);
}

/////////
final class FavoriteDoctorByIdLoading extends FavoriteDoctorsState {}

final class FavoriteDoctorByIdLoaded extends FavoriteDoctorsState {
  final Doctor? favoriteDoctor;
  const FavoriteDoctorByIdLoaded(this.favoriteDoctor);
}

/////////
final class FavoriteDoctorsError extends FavoriteDoctorsState {
  final String message;
  const FavoriteDoctorsError(this.message);
}
