sealed class UserState {}

final class UserStateInitial extends UserState {}

final class UserNotLogged extends UserState {}

final class UserLoggedAndLoading extends UserState {}

final class UserLoggedAndLoadingSuccess extends UserState {
  final dynamic user;
  UserLoggedAndLoadingSuccess({required this.user});
}

final class UserLoggedAndLoadingFailure extends UserState {}
