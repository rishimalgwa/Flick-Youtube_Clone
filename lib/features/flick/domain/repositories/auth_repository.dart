import 'package:dartz/dartz.dart';
import 'package:flick/core/auth_failures.dart';
import 'package:flick/core/failures.dart';
import 'package:flick/features/flick/data/models/userModel.dart';

abstract class AuthRepository {
  Future<Either<AuthFailures, Unit>> signInWithGoogle();
  Future<UserModel> getUser();
  Future<bool> isSignedIn();
  Future<void> signOut();
}
