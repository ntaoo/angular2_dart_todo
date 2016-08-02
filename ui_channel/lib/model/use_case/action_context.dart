import 'package:angular2/core.dart';
import 'package:todo_app/ui_channel/ui_channel.dart' show Context, Action;
import 'todo_list/actions.dart';
import 'todo_list/contexts.dart' as todo_list;

@Injectable()
class ActionContext {
  Context call(Action action) {
    // Prefer plain switch statement than double dispatch with each action.
    // TODO: It might better to use reflection instead of this switch statement.
    switch (action.runtimeType) {
      case UserAddedTodo:
        return new todo_list.UserAddedTodo(action);
      case UserUpdatedText:
        return new todo_list.UserUpdatedText(action);
      case UserUpdatedCompletion:
        return new todo_list.UserUpdatedCompletion(action);
      case UserRemovedTodo:
        return new todo_list.UserRemovedTodo(action);
      case UserChangedVisibilityFilter:
        return new todo_list.UserChangedVisibilityFilter(action);
      default:
        // TODO: Define an Error class extends Error.
        throw 'action not found';
    }
  }
}
