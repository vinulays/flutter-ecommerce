part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserLocal user;

  AuthenticationAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class SignUpInProgress extends AuthenticationState {}

class SignUpSuccess extends AuthenticationState {}

class SignUpFailure extends AuthenticationState {
  final String errorMessage;

  SignUpFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
