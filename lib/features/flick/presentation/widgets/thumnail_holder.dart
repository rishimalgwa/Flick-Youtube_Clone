import 'dart:io';

import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailHolder extends StatefulWidget {
  final VideoModel videoModel;
  const ThumbnailHolder(
    this.videoModel,
  );

  @override
  _ThumbnailHolderState createState() => _ThumbnailHolderState();
}

class _ThumbnailHolderState extends State<ThumbnailHolder> {
  String filepath;

  String tempPath;
  Future<void> videoThumbnail() async {
    Directory tempDir = await getTemporaryDirectory();
    tempPath = tempDir.path;
    final fileName = await VideoThumbnail.thumbnailFile(
      video: widget.videoModel.url,
      thumbnailPath: tempPath,
      imageFormat: ImageFormat.WEBP,
      quality: 100,
      timeMs: 20000,
    );
    setState(() {
      filepath = fileName;
    });
  }

  @override
  void initState() {
    super.initState();
    videoThumbnail();
  }

  @override
  void dispose() {
    super.dispose();
    tempPath = null;
  }

  @override
  Widget build(BuildContext context) {
    var uploadTearList = widget.videoModel.uploadDate.split(",");
    String uploadYear = uploadTearList[1];

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.grey,
                  height: 190,
                  width: double.infinity,
                  child: filepath == null
                      ? Container()
                      : Image.file(
                          File(filepath),
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      padding: const EdgeInsets.all(1),
                      height: 18,
                      width: 30,
                      child: Center(
                        child: Text(
                          widget.videoModel.length,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.black26,
              padding: const EdgeInsets.all(8),
              height: 60,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.videoModel.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(widget.videoModel.channelName),
                          SizedBox(width: 7),
                          CircleAvatar(
                            radius: 1,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 7),
                          Text(widget.videoModel.views.toString()),
                          SizedBox(width: 7),
                          CircleAvatar(
                            radius: 1,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 7),
                          Text(uploadYear),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      switch (value) {
                        case 'Logout':
                          break;
                        case 'Settings':
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Save to playlist', 'Share'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
