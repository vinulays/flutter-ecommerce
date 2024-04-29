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

class SignUpRequested extends AuthenticationEvent {
  final String displayName;
  final String username;
  final String email;
  final String mobileNumber;
  final String password;
  final String role;

  SignUpRequested(
      {required this.displayName,
      required this.username,
      required this.email,
      required this.mobileNumber,
      required this.password,
      required this.role});

  @override
  List<Object> get props =>
      [displayName, username, email, mobileNumber, password, role];
}

class SignUpWithGoogleEvent extends AuthenticationEvent {}

class SignUpWithFacebookEvent extends AuthenticationEvent {}

class LogoutRequested extends AuthenticationEvent {
  final BuildContext context;

  LogoutRequested(this.context);
}

class ChangeUsernameEvent extends AuthenticationEvent {
  final String username;

  ChangeUsernameEvent(this.username);
}

class ChangePhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;

  ChangePhoneNumberEvent(this.phoneNumber);
}

class ChangePasswordEvent extends AuthenticationEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent(this.currentPassword, this.newPassword);
}

class UpdateAvatarEvent extends AuthenticationEvent {
  final File image;
  final String userId;

  UpdateAvatarEvent(this.image, this.userId);
}
