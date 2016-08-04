import 'dart:async';
import 'package:angular2/core.dart';
import 'package:stream_channel/stream_channel.dart';
import 'src/action.dart';
import 'src/router.dart';
import 'src/dispatcher.dart';
import 'src/state.dart';
import 'src/state_transformer.dart';

export 'src/action.dart';
export 'src/controller.dart';
export 'src/router.dart';
export 'src/dispatcher.dart';
export 'src/state.dart';

@Injectable()
UIChannel uiChannelFactory(State state, Router router) =>
    new UIChannel.transformStreamWith(
        new StateTransformer(state, router));

@Injectable()
Dispatcher dispatcherFactory(UIChannel channel) => new Dispatcher(channel.sink);


// TODO: Instead of extending Object, extending LayerChannel which has logging and some capability?
class UIChannel extends Object with StreamChannelMixin {
  final Stream<State> stream;
  final StreamSink<Action> sink;

  factory UIChannel.transformStreamWith(StreamTransformer transformer) {
    var controller = new StreamChannelController(allowForeignErrors: false);
    // Transform local [Action] stream to [AppState] stream and pipe to local sink.
    controller.local.stream.transform(transformer).pipe(controller.local.sink);
    return new UIChannel._(controller.foreign.stream, controller.foreign.sink);
  }
  UIChannel._(this.stream, this.sink);
}
