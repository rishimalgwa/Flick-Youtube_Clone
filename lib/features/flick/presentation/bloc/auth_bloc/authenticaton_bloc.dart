import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/data/repositories/auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

part 'authenticaton_event.dart';
part 'authenticaton_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepositoryImpl authRepositoryImpl;
  AuthenticationBloc({@required this.authRepositoryImpl})
      : assert(authRepositoryImpl != null),
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await authRepositoryImpl.isSignedIn();
      if (isSignedIn) {
        final user = await authRepositoryImpl.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await authRepositoryImpl.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    authRepositoryImpl.signOut();
  }
}
