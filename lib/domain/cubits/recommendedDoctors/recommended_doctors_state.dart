part of 'recommended_doctors_cubit.dart';

sealed class RecommendedDoctorsState extends Equatable {
  const RecommendedDoctorsState();

  @override
  List<Object> get props => [];
}

final class RecommendedDoctorsInitial extends RecommendedDoctorsState {}

class RecommendedDoctorsLoading extends RecommendedDoctorsState {}

class RecommendedDoctorsLoaded extends RecommendedDoctorsState {
  final List<Doctor> recommendedDoctors;
  const RecommendedDoctorsLoaded(this.recommendedDoctors);
}

class RecommendedDoctorsError extends RecommendedDoctorsState {
  final String message;
  const RecommendedDoctorsError(this.message);
}
