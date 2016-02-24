import "package:angular2/angular2.dart";

import "action_dispatcher.dart";
import "actions.dart";

@Injectable()
class Intent {
  final ActionDispatcher _dispatcher;

  Intent(this._dispatcher);

  void addTodo(String text) {
    _dispatcher.dispatch(new UserAddedTodo(text));
  }

  void launchApp() {
    _dispatcher.dispatch(new UserLaunchedApp());
  }

  void removeTodo(String id) {
    _dispatcher.dispatch(new UserRemovedTodo(id));
  }

  void updateCompletion(String id, bool isCompleted) {
    _dispatcher.dispatch(new UserUpdatedCompletion(id, isCompleted));
  }

  void updateText(String id, String text) {
    _dispatcher.dispatch(new UserUpdatedText(id, text));
  }
}