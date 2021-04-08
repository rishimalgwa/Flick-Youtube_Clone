import 'package:flick/features/flick/data/repositories/auth_repository_impl.dart';
import 'package:flick/features/flick/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flick/features/flick/presentation/widgets/google_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepositoryImpl _userRepository;

  LoginScreen({Key key, @required AuthRepositoryImpl userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  AuthRepositoryImpl get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      authRepositoryImpl: _userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
