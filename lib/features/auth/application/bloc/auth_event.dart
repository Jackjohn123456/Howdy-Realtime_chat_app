part of 'auth_bloc.dart';

sealed class AuthEvent{}

class RegisterEvent extends AuthEvent{
  final String password;
  final String username;
  final String email;

  RegisterEvent({required this.password, required this.username, required this.email});
}

class LoginEvent extends AuthEvent{
  final String password;
  final String email;

  LoginEvent({required this.password, required this.email});
}