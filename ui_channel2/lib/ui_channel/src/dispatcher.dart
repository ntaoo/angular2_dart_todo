import 'dart:async';

// TODO: logger instead of print.
class Dispatcher<T> {
  final StreamSink _sink;
  final bool _dump;
  Dispatcher(this._sink, [this._dump = true]);
  void dispatch(T t) {
    _sink.add(t);
    if (_dump) print(t.toString());
  }
}
