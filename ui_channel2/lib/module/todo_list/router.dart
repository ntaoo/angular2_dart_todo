import 'package:angular2/core.dart';
import 'package:todo_app/ui_channel/ui_channel.dart' show Action, Controller, Router;
import 'package:todo_app/module/todo_list/actions.dart' as a;
import 'package:todo_app/module/todo_list/controller/controller.dart';

@Injectable()
class TodoListRouter implements Router {
  Injector injector;
  TodoListRouter(this.injector);
  Controller call(Action action) {
    // TODO: It might better to use reflection instead of this switch statement.
    switch (action.runtimeType) {
      case a.UserAddedTodo:
        return injector.get(UserAddedTodo);
      case a.UserUpdatedText:
        return injector.get(UserUpdatedText);
      case a.UserUpdatedCompletion:
        return injector.get(UserUpdatedCompletion);
      case a.UserRemovedTodo:
        return injector.get(UserRemovedTodo);
      case a.UserChangedVisibilityFilter:
        return injector.get(UserChangedVisibilityFilter);
      default:
        throw new ArgumentError('Unknown Action: $action');
    }
  }
}
