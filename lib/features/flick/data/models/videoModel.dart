import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick/features/flick/domain/entities/videos.dart';
import 'package:flutter/foundation.dart';

class VideoModel extends Video {
  VideoModel(
      {@required String title,
      @required String description,
      @required String url,
      @required String uploadedBy,
      @required String id,
      @required int likes,
      @required int dislikes,
      @required int views,
      @required String channelName,
      @required String length,
      @required String uploadDate,
      @required String uploadTime,
      @required List<String> tags})
      : super(
            channelName: channelName,
            views: views,
            description: description,
            title: title,
            url: url,
            uploadedBy: uploadedBy,
            id: id,
            likes: likes,
            dislikes: dislikes,
            length: length,
            uploadDate: uploadDate,
            uploadTime: uploadTime,
            tags: tags);
  factory VideoModel.fromDoc(DocumentSnapshot snap) {
    var doc = snap.data();
    return VideoModel(
        channelName: doc['channelName'],
        views: doc['views'],
        title: doc['title'],
        description: doc['description'],
        url: doc['url'],
        uploadedBy: doc['uploadedBy'],
        id: snap.id,
        likes: doc['likes'],
        dislikes: doc['dislikes'],
        length: doc['length'],
        uploadDate: doc['uploadDate'],
        uploadTime: doc['uploadTime'],
        tags: doc['tags'].cast<String>());
  }
}
