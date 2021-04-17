import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flick/features/flick/data/models/videoModel.dart';

abstract class Repository {
  Future<Either<FirebaseException, Unit>> uploadVideo();
  Future<List<VideoModel>> fetchVideo();
}
