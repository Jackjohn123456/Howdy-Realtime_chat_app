import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howdy/features/auth/domain/usecases/login_use_case.dart';
import 'package:howdy/features/auth/domain/usecases/register_use_case.dart';

part 'auth_state.dart';
part 'auth_event.dart';


class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();

  AuthBloc(this.registerUseCase, this.loginUseCase):super(AuthInitial()){
   on<RegisterEvent>(_onRegister);
   on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await registerUseCase.call(username: event.username, email:event.email, password:event.password);
      await _storage.write(key: "token", value:user.token);
      emit(AuthSuccess(
          message:"Registration Successful"
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await loginUseCase.call(email: event.email, password: event.password);
      debugPrint("::::::::::::user.token");
      debugPrint(user.token);
      await _storage.write(key: "token", value:user.token);
      await _storage.write(key: "userId", value:user.id);
      emit(AuthSuccess(
          message:"Login Successful"
      ));
    } on Exception catch (e) {
      emit(AuthFailure(error: 'Login Error $e'));
    }
  }
}