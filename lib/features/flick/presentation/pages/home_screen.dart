import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/presentation/bloc/auth_bloc/authenticaton_bloc.dart';
import 'package:flick/features/flick/presentation/pages/upload_video_screen.dart';
import 'package:flick/features/flick/presentation/widgets/thumnail_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UploadVideoPage();
          }));
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}
