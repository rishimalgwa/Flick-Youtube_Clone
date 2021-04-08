import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String email, uid, username, channelName;
  final int subscribers, videosCount;
  final List<String> videoIds;

  User(
      {@required this.email,
      @required this.uid,
      @required this.username,
      this.channelName,
      this.subscribers,
      this.videosCount,
      this.videoIds});

  @override
  List<Object> get props =>
      [email, uid, username, channelName, subscribers, videosCount, videoIds];
}
