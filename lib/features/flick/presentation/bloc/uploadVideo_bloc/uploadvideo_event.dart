part of 'uploadvideo_bloc.dart';

abstract class UploadvideoEvent extends Equatable {
  const UploadvideoEvent();

  @override
  List<Object> get props => [];
}

class VideoUploadRequest extends UploadvideoEvent {
  final String title;
  final File file;
  final String description;
  final String length;
  final String uploadedBy;
  final List<String> tags;

  VideoUploadRequest(
      {this.title,
      this.file,
      this.description,
      this.length,
      this.uploadedBy,
      this.tags});
}
