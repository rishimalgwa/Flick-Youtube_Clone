part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGooglePressed';
}
