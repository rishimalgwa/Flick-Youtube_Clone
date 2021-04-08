part of 'authenticaton_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final UserModel user;

  Authenticated(this.user);
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'Authenticated { displayName: $user }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
