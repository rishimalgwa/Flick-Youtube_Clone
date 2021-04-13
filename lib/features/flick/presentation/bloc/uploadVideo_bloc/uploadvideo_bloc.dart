import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flick/features/flick/data/repositories/repository_impl.dart';

part 'uploadvideo_event.dart';
part 'uploadvideo_state.dart';

class UploadvideoBloc extends Bloc<UploadvideoEvent, UploadvideoState> {
  final RepositoryImpl repositoryImpl;

  UploadvideoBloc({this.repositoryImpl}) : super(VideoUploadInitial());
  @override
  Stream<UploadvideoState> mapEventToState(
    UploadvideoEvent event,
  ) async* {
    if (event is VideoUploadRequest) {
      yield VideoUploadingState();
      final result = await repositoryImpl.uploadVideo(
          title: event.title,
          file: event.file,
          description: event.description,
          length: event.length,
          uploadedBy: event.uploadedBy,
          tags: event.tags);

      yield result.fold((l) => VideoUploadFailureState(l.message),
          (r) => VideoUploadSuccessState());
    }
  }
}
