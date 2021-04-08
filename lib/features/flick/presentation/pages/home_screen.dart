import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/presentation/bloc/auth_bloc/authenticaton_bloc.dart';
import 'package:flick/features/flick/presentation/widgets/thumnail_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File _image;
    final picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Text('FLICK'),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
          child: SvgPicture.asset(
            'assets/logo.svg',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ThumbnailHolder();
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () async {
          final pickedFile = await picker.getVideo(source: ImageSource.gallery);
          var filepath = File(pickedFile.path);
          String path = filepath.path;
          final videoInfo = FlutterVideoInfo();

          var info = await videoInfo.getVideoInfo(path);
          print(path);
          print(info.duration * 0.001);
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}
