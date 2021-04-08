import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flick/features/flick/data/repositories/auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryImpl authRepositoryImpl;
  LoginBloc({this.authRepositoryImpl})
      : assert(authRepositoryImpl != null),
        super(LoginState.empty());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      final userOption = await authRepositoryImpl.signInWithGoogle();
      yield userOption.fold(
          (l) => LoginState.failure(), (r) => LoginState.success());
    }
  }
}
