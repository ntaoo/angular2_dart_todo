import 'dart:async';
import 'action.dart';
import 'router.dart';
import 'state.dart';

/// Transforming [Action] stream to [State] stream with a router and controller call.
class StateTransformer implements StreamTransformer {
  StreamController _controller;
  StreamSubscription _subscription;
  bool cancelOnError;
  Stream<Action> _actionStream;
  State state;
  Router router;

  StateTransformer(this.state, this.router) {
    _controller = new StreamController<State>(
        onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription.pause();
        },
        onResume: () {
          _subscription.resume();
        });
  }

  void _onListen() {
    _subscription = _actionStream.listen(onData,
        onError: _controller.addError,
        onDone: _controller.close,
        cancelOnError: cancelOnError);
  }

  void _onCancel() {
    _subscription.cancel();
    _subscription = null;
  }

  // Transformation.
  Future<Null> onData(Action action) async {
    // Accepts Future<AppState> or AppState by new Future.sync().
    _controller.add(await new Future.sync(() => router(action)(state, action)));
  }

  // Bind.
  Stream<State> bind(Stream<Action> actionStream) {
    _actionStream = actionStream;
    return _controller.stream;
  }
}
