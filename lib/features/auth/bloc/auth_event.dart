import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignInWithFacebookEvent extends AuthEvent {}

class SignInWithTwitterEvent extends AuthEvent {}

class SendPasswordResetEmailEvent extends AuthEvent {
  final String email;

  const SendPasswordResetEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class ConfirmPasswordResetEvent extends AuthEvent {
  final String code;
  final String newPassword;

  const ConfirmPasswordResetEvent({required this.code, required this.newPassword});

  @override
  List<Object?> get props => [code, newPassword];
}
