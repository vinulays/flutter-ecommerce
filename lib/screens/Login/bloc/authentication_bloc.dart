import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/repositories/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationInitial()) {
    on<UserLoginRequested>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        final user = await _authRepository.loginWithEmailAndPassword(
            event.email, event.password);

        if (user != null) {
          emit(AuthenticationAuthenticated(user));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } catch (e) {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(SignUpInProgress());

      try {
        await _authRepository.signUp(event.email, event.password,
            event.displayName, event.username, event.mobileNumber, event.role);

        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure("Failed to sign up: $e"));
      }
    });

    on<SignUpWithGoogleEvent>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        final UserLocal? user = await _authRepository.signUpWithGoogle();
        if (user != null) {
          emit(AuthenticationAuthenticated(user));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } catch (e) {
        throw Exception("failed sign up google: $e");
        // emit(AuthenticationUnauthenticated());
      }
    });
  }
}
