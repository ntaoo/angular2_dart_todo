import 'dart:async';
import 'action.dart';
import 'state.dart';

abstract class Context {
  // Define ActionStream extends Stream?
  Action action;
  Future<State> call(State state);
}