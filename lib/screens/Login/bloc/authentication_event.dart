part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {}

class UserLoggedOut extends AuthenticationEvent {}

class UserLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  UserLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
