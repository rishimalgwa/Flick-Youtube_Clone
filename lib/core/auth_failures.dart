import 'package:flick/core/failures.dart';

class AuthFailures extends Failure {
  @override
  List<Object> get props => throw UnimplementedError();
}

class CancelledByUser extends AuthFailures {}

class ServerError extends AuthFailures {}
