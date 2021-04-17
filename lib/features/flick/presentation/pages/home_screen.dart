import 'package:flick/features/flick/data/models/userModel.dart';
import 'package:flick/features/flick/data/models/videoModel.dart';
import 'package:flick/features/flick/data/repositories/repository_impl.dart';
import 'package:flick/features/flick/presentation/bloc/auth_bloc/authenticaton_bloc.dart';
import 'package:flick/features/flick/presentation/pages/upload_video_screen.dart';
import 'package:flick/features/flick/presentation/widgets/shrimmer_holder.dart';
import 'package:flick/features/flick/presentation/widgets/thumnail_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RepositoryImpl repositoryImpl = RepositoryImpl();
  List<VideoModel> videos = [];

  @override
  void initState() {
    super.initState();
  }

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
      body: FutureBuilder(
          future: repositoryImpl.fetchVideo(),
          builder: (context, snapshot) {
            bool isWating = snapshot.connectionState == ConnectionState.waiting;
            return ListView.builder(
                itemCount: isWating ? 8 : snapshot.data.length,
                itemBuilder: (context, index) {
                  return isWating
                      ? ShimmerThumbnailHolder()
                      : ThumbnailHolder();
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UploadVideoPage();
          })).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Video Uploaded'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.white,
                ),
              ));
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}
