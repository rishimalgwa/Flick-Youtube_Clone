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
      @required int length,
      @required int uploadDate,
      @required int uploadTime,
      @required List<String> tags})
      : super(
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
  factory VideoModel.fromDoc(DocumentSnapshot doc) {
    return VideoModel(
        title: doc['title'],
        description: doc['description'],
        url: doc['url'],
        uploadedBy: doc['uploadedBy'],
        id: doc.id,
        likes: doc['likes'],
        dislikes: doc['dislikes'],
        length: doc['length'],
        uploadDate: doc['uploadDate'],
        uploadTime: doc['uploadTime'],
        tags: doc['tags']);
  }
}
