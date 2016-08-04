import 'dart:async';
import 'action.dart';
import 'state.dart';

abstract class Controller {
  Future<State> call(State state, Action action);
}
