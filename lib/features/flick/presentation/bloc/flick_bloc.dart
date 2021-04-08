import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'flick_event.dart';
part 'flick_state.dart';

class FlickBloc extends Bloc<FlickEvent, FlickState> {
  FlickBloc() : super(FlickInitial());
  @override
  Stream<FlickState> mapEventToState(
    FlickEvent event,
  ) async* {}
}
