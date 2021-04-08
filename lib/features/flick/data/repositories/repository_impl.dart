import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flick/features/flick/domain/repositories/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RepositoryImpl extends Repository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future uploadVideo(
      {@required String title,
      @required File file,
      @required String description,
      @required int length,
      @required int uploadDate,
      @required int uploadTime,
      @required List<String> tags}) async {
    var uuid = Uuid().v4();
    DateTime now = new DateTime.now();
    String date = DateFormat.yMMMMd('en_US').format(now);
    String time = DateFormat.Hm().format(now);
    var snapshot = await _firebaseStorage
        .ref('videos')
        .child(uuid)
        .putFile(file, SettableMetadata(contentType: 'video/mp4'));
    var downloadUrl = await snapshot.ref.getDownloadURL();
    _firestore.doc('Videos').collection(uuid).add({
      "title": title,
      "description": description,
      "url": downloadUrl,
      "uploadedBy": 'df',
      "id": uuid,
      "likes": 0,
      "dislikes": 0,
      "length": 1231,
      "uploadDate": date,
      "uploadTime": time,
      "tags": tags
    });
  }

  Future<VideoModel> fetchVideo() {}
}
