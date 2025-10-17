part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AppStarted extends AuthEvent {}

final class LoginRequested extends AuthEvent {
  const LoginRequested({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}

final class LogoutRequested extends AuthEvent {}
