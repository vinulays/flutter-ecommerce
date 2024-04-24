import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;
  final AuthService _authService;

  AuthenticationBloc(
      {required FirebaseAuth firebaseAuth, required AuthService authService})
      : _firebaseAuth = firebaseAuth,
        _authService = authService,
        super(AuthenticationInitial()) {
    // on<AppStarted>((event, emit) async {
    //   try {
    //     final user = await _firebaseAuth.authStateChanges().first;

    //     if (user != null) {
    //       emit(AuthenticationAuthenticated(user));
    //     } else {
    //       emit(AuthenticationUnauthenticated());
    //     }
    //   } catch (e) {
    //     emit(AuthenticationUnauthenticated());
    //   }
    // });

    // on<UserLoggedIn>((event, emit) async {
    //   emit(AuthenticationAuthenticated(_firebaseAuth.currentUser!));
    // });

    on<UserLoggedOut>((event, emit) async {
      _firebaseAuth.signOut();
      emit(AuthenticationUnauthenticated());
    });

    on<UserLoginRequested>((event, emit) async {
      emit(AuthenticationLoading());

      final user = await _authService.loginWithEmailPassword(
          event.email, event.password);

      if (user != null) {
        emit(AuthenticationAuthenticated(user));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
