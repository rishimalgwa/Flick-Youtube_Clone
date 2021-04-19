import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick/features/flick/domain/entities/users.dart';
import 'package:flutter/foundation.dart';

class UserModel extends User {
  UserModel(
      {@required String email,
      @required String uid,
      @required String username,
      @required String logoUrl,
      String channelName,
      int subscribers,
      int videosCount,
      List<String> videoIds})
      : super(
            logoUrl: logoUrl,
            username: username,
            email: email,
            uid: uid,
            channelName: channelName,
            subscribers: subscribers,
            videosCount: videosCount,
            videoIds: videoIds);
  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      logoUrl: doc['logoUrl'],
      username: doc['username'],
      email: doc['email'],
      channelName: doc['channelName'] ?? '',
      videoIds: doc['videoIds'].cast<String>(),
      subscribers: doc['subscribers'] ?? 0,
      videosCount: doc['videosCount'] ?? 0,
    );
  }
}
