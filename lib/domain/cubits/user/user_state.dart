sealed class UserState {}

final class UserStateInitial extends UserState {}

final class UserLogged extends UserState {}

final class UserNotLogged extends UserState {}

final class UserLoading extends UserState {}

final class UserLoadingSuccess extends UserState {}

final class UserLoadingFailure extends UserState {}
