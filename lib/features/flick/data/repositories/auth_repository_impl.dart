import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/core/auth_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepositoryImpl({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();
  @override
  Future<Either<AuthFailures, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(CancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      List<String> videoLinks = [];
      await _firebaseAuth.signInWithCredential(authCredential);
      User user = _firebaseAuth.currentUser;
      _firestore.collection('Users').doc(user.uid).set({
        "email": user.email,
        "uid": user.uid,
        "username": user.displayName,
        "channelName": '',
        "subscribers": 0,
        "videosCount": 0,
        "videoIds": videoLinks,
      });
      return right(unit);
    } on FirebaseAuthException catch (_) {
      return left(ServerError());
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserModel> getUser() async {
    DocumentSnapshot snapshot = await _firestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser.uid)
        .get();
    return UserModel.fromDoc(snapshot);
  }

  @override
  Future<void> signOut() {
    return Future.wait([_googleSignIn.signOut(), _firebaseAuth.signOut()]);
  }
}
