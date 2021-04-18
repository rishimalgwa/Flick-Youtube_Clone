import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/features/flick/data/repositories/repository_impl.dart';
import 'package:flick/features/flick/presentation/bloc/uploadVideo_bloc/uploadvideo_bloc.dart';
import 'package:flick/features/flick/presentation/widgets/chewie_item.dart';
import 'package:flick/features/flick/presentation/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class UploadVideoPage extends StatefulWidget {
  UploadVideoPage({Key key}) : super(key: key);

  @override
  _UploadVideoPageState createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  List itemTags = [];
  List<String> tags = [];
  TextEditingController titleController;
  TextEditingController descriptionController;
  final RepositoryImpl repositoryImpl = RepositoryImpl();
  UploadvideoBloc _uploadvideoBloc;
  final picker = ImagePicker();
  String filePath;
  String length;
  File _video;
  String title, description;
  bool isUploading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _uploadvideoBloc = UploadvideoBloc(repositoryImpl: repositoryImpl);
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  Future<void> genThumbnailFile() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      _video = File(pickedFile.path);
      filePath = _video.path;
    });
    String path = _video.path;

    final videoInfo = FlutterVideoInfo();
    var info = await videoInfo.getVideoInfo(path);
    var minutes = (info.duration / 60000).floor();
    var seconds = ((info.duration % 60000) / 1000).toPrecision(0);
    length = "$minutes:${(seconds < 10 ? "0" : "")}${seconds.floor()}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _uploadvideoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add details',
            style: TextTheme().headline3,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  child: Text('Upload'),
                  color: Colors.blueAccent,
                  onPressed: isUploading
                      ? null
                      : () {
                          setState(() {
                            isUploading = true;
                          });
                          titleController.text != null
                              ? title = titleController.text
                              : title = "No title";
                          descriptionController.text != null
                              ? description = descriptionController.text
                              : title = "";
                          itemTags.forEach((element) {
                            tags.add(element.title);
                          });
                          _uploadvideoBloc.add(VideoUploadRequest(
                              title: title,
                              description: description,
                              file: _video,
                              length: length,
                              tags: tags,
                              uploadedBy: auth.currentUser.uid));
                        }),
            )
          ],
        ),
        body: BlocBuilder(
            bloc: _uploadvideoBloc,
            builder: (context, state) {
              if (state is VideoUploadInitial) {
                return SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * .35,
                          child: filePath != null
                              ? Container(
                                  width: 400,
                                  height: 200,
                                  child: ChewieListItem(
                                    videoPlayerController:
                                        VideoPlayerController.file(_video),
                                    looping: false,
                                  ))
                              : Container(
                                  color: Colors.black38,
                                  width: size.width,
                                  child: IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.play,
                                      size: 50,
                                    ),
                                    onPressed: () async {
                                      await genThumbnailFile();
                                    },
                                  ),
                                ),
                        ),
                        CustomTextField(
                          label: 'Title',
                          hint: 'Create a title',
                          controller: titleController,
                          iconData: FontAwesomeIcons.info,
                        ),
                        CustomTextField(
                          label: 'Description',
                          hint: 'Describe your video',
                          controller: descriptionController,
                          iconData: FontAwesomeIcons.pen,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Tags(
                              itemCount: itemTags.length,
                              itemBuilder: (index) {
                                final Item currentItem = itemTags[index];
                                return ItemTags(
                                  index: index,
                                  title: currentItem.title,
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  combine: ItemTagsCombine.withTextBefore,
                                  removeButton: ItemTagsRemoveButton(
                                    onRemoved: () {
                                      setState(() {
                                        itemTags.removeAt(index);
                                      });
                                      return true;
                                    },
                                  ),
                                );
                              },
                              textField: TagsTextField(
                                onSubmitted: (tag) {
                                  setState(() {
                                    itemTags.add(Item(title: tag));
                                  });
                                },
                                inputDecoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  labelText: 'Tags',
                                  labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.tags,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Tags here',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              } else if (state is VideoUploadingState) {
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is VideoUploadSuccessState) {
                Navigator.pop(context, 'success');
                return Center(
                    child: Container(
                        child: Text(
                  'success',
                  style: TextStyle(fontSize: 20),
                )));
              } else if (state is VideoUploadFailureState) {
                return Center(
                    child: Container(
                        child: Text(
                  'Something went wrong',
                  style: TextStyle(fontSize: 20),
                )));
              } else {
                return Center(
                    child: Container(
                        child: Text(
                  'Something really bad happend. Contact developer.',
                  style: TextStyle(fontSize: 20),
                )));
              }
            }),
      ),
    );
  }
}
