import 'package:firebase_core/firebase_core.dart';
import 'package:flick/features/flick/data/repositories/auth_repository_impl.dart';
import 'package:flick/features/flick/presentation/bloc/auth_bloc/authenticaton_bloc.dart';
import 'package:flick/features/flick/presentation/pages/home_screen.dart';
import 'package:flick/features/flick/presentation/pages/login_screen.dart';
import 'package:flick/features/flick/presentation/pages/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/flick/presentation/bloc/auth_bloc/authenticaton_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final AuthRepositoryImpl _userRepository = AuthRepositoryImpl();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(authRepositoryImpl: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.red,
          focusColor: Colors.redAccent,
          highlightColor: Colors.redAccent,
          hintColor: Colors.white,
        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            } else if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            } else if (state is Authenticated) {
              return HomeScreen(user: state.user);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
