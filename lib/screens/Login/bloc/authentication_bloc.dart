import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/repositories/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;
  final AuthRepository _authRepository;

  AuthenticationBloc(
      {required FirebaseAuth firebaseAuth,
      required AuthRepository authRepository})
      : _firebaseAuth = firebaseAuth,
        _authRepository = authRepository,
        super(AuthenticationInitial()) {
    on<UserLoginRequested>((event, emit) async {
      emit(AuthenticationLoading());

      final user = await _authRepository.loginWithEmailAndPassword(
          event.email, event.password);

      if (user != null) {
        emit(AuthenticationAuthenticated(user));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
