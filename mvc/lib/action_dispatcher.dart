import "package:angular2/angular2.dart";
import "actions.dart";
import "on_action.dart";

const bool _dump = true;

@Injectable()
class ActionDispatcher extends EventEmitter {
  ActionDispatcher(OnAction _onAction) : super() {
    this.listen(_onAction);
  }
  void dispatch(Action action) {
    add(action);
    if (_dump) action.dump();
  }
}
