import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flick/features/flick/presentation/widgets/chewie_item.dart';
import 'package:flick/features/flick/presentation/widgets/lable_icons.dart';
import 'package:flick/features/flick/presentation/widgets/seprator.dart';
import 'package:flick/features/flick/presentation/widgets/shrimmer_holder.dart';
import 'package:flick/features/flick/presentation/widgets/thumnail_holder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 400,
            height: size.height * .35,
            child: ChewieListItem(
              videoPlayerController: VideoPlayerController.network(
                  'https://firebasestorage.googleapis.com/v0/b/flick-64314.appspot.com/o/videos%2F1afaac13-820b-4b85-859d-b42f21fe9be3?alt=media&token=6ec49b8d-7d1b-46d2-ab9d-8030a4360033'),
              looping: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(11, 5, 11, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * .8,
                        child: Text(
                          'Title here',
                          textAlign: TextAlign.left,
                          maxLines: 20,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '4.7M views',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 7),
                          CircularSeprator(),
                          SizedBox(width: 7),
                          Text(
                            '1 year ago',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(FontAwesomeIcons.angleDown), onPressed: () {}),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIcons(
                iconData: FontAwesomeIcons.thumbsUp,
                text: '12k',
                onPressed: null,
              ),
              CustomIcons(
                iconData: FontAwesomeIcons.thumbsDown,
                text: '1k',
                onPressed: null,
              ),
              CustomIcons(
                iconData: FontAwesomeIcons.share,
                text: 'Share',
                onPressed: null,
              ),
              CustomIcons(
                iconData: Icons.save_alt,
                text: 'Downlaod',
                onPressed: null,
              ),
              CustomIcons(
                iconData: FontAwesomeIcons.plusSquare,
                text: 'Save',
                onPressed: null,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          HorizontalSeprator(),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 18,
                ),
                Column(
                  children: [
                    Text(
                      'channel name',
                      style: TextStyle(fontSize: 19),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '16k Subcribers',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'SUBSCRIBE',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          HorizontalSeprator(),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Comments',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '200',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.arrow_drop_down), onPressed: null)
                  ],
                )
              ],
            ),
          ),
          HorizontalSeprator(),
          Container(
            height: 220,
            child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ShimmerThumbnailHolder();
                }),
          )
        ],
      ),
    );
  }
}
