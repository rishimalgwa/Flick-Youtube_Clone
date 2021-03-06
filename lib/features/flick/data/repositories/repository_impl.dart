import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flick/features/flick/data/repositories/auth_repository_impl.dart';
import 'package:flick/features/flick/domain/repositories/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RepositoryImpl extends Repository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  Future<Either<FirebaseException, Unit>> uploadVideo(
      {@required String title,
      @required File file,
      @required String description,
      @required String length,
      @required String uploadedBy,
      @required List<String> tags}) async {
    var uuid = Uuid().v4();
    DateTime now = new DateTime.now();
    String date = DateFormat.yMMMMd('en_US').format(now);
    String time = DateFormat.Hm().format(now);
    try {
      UserModel model = await authRepositoryImpl.getUser();
      var snapshot = await _firebaseStorage
          .ref('videos')
          .child(uuid)
          .putFile(file, SettableMetadata(contentType: 'video/mp4'));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      _firestore.collection('Videos').doc(uuid).set({
        "logoUrl": model.logoUrl,
        "title": title,
        "description": description,
        "channelName": model.username, // change to channelName
        "url": downloadUrl,
        "uploadedBy": uploadedBy,
        "id": uuid,
        'views': 0,
        "likes": 0,
        "dislikes": 0,
        "length": length,
        "uploadDate": date,
        "uploadTime": time,
        "tags": tags
      });

      List<String> videoIds = model.videoIds;
      int videoCount = videoIds.length;
      videoIds.add(uuid);
      videoCount = videoIds.length;
      _firestore
          .collection('Users')
          .doc(uploadedBy)
          .update({"videoIds": videoIds, "videosCount": videoCount});
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  Future<List<VideoModel>> fetchVideo() async {
    List<VideoModel> videoList = [];
    await _firestore
        .collection('Videos')
        .get()
        .then((value) => value.docs.forEach((doc) {
              videoList.add(VideoModel.fromDoc(doc));
            }));
    return videoList;
  }
}
