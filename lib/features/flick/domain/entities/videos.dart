import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Video extends Equatable {
  final String title, description, url, uploadedBy, id, channelName;
  final int likes, dislikes, views;
  final String length;
  final String uploadDate, uploadTime;
  final List<String> tags;

  Video(
      {@required this.channelName,
      @required this.views,
      @required this.title,
      @required this.description,
      @required this.url,
      @required this.uploadedBy,
      @required this.id,
      @required this.likes,
      @required this.dislikes,
      @required this.length,
      @required this.uploadDate,
      @required this.uploadTime,
      @required this.tags});
  @override
  List<Object> get props => [
        channelName,
        views,
        title,
        description,
        url,
        uploadedBy,
        id,
        likes,
        dislikes,
        length,
        uploadDate,
        uploadTime,
        tags
      ];
}
