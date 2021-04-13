part of 'uploadvideo_bloc.dart';

abstract class UploadvideoState extends Equatable {
  const UploadvideoState();

  @override
  List<Object> get props => [];
}

class VideoUploadInitial extends UploadvideoState {}

class VideoUploadingState extends UploadvideoState {}

class VideoUploadSuccessState extends UploadvideoState {}

class VideoUploadFailureState extends UploadvideoState {
  final String errorMessage;

  VideoUploadFailureState(this.errorMessage);
}
