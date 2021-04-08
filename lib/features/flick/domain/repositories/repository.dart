import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flick/features/flick/domain/entities/videos.dart';

abstract class Repository {
  Future uploadVideo();
  Future<VideoModel> fetchVideo();
}
