import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String? profileImgUrl;
  final String? fcmToken;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    this.profileImgUrl,
    this.fcmToken,
  });

  @override
  List<Object?> get props => [name, email, password, profileImgUrl, fcmToken];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  ForgotPasswordRequested(this.email);
  @override
  List<Object?> get props => [email];
}
