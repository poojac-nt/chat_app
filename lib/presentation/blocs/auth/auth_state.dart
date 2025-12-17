import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final String message;
  Authenticated({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final Failure message;

  AuthError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SignOutError extends AuthState {
  final Failure message;
  SignOutError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
