import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';
import '../data/models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo, {required AuthRepository authRepository}) : super(const AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserModel? user = await _repo.signInWithGoogle();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Google sign-in cancelled'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignInWithFacebookEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserModel? user = await _repo.signInWithFacebook();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Facebook sign-in cancelled'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignInWithTwitterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserModel? user = await _repo.signInWithTwitter();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Twitter sign-in cancelled'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.signIn(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _repo.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }
}
