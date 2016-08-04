import "package:angular2/angular2.dart";

import "package:todo_app/ui_channel/ui_channel.dart" show Dispatcher;
import "package:todo_app/module/todo_list/actions.dart";

@Injectable()
class Intent {
  final Dispatcher _dispatcher;

  Intent(this._dispatcher);

  void addTodo(String text) {
    _dispatcher.dispatch(new UserAddedTodo(text));
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