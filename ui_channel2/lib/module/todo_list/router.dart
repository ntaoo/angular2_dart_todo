import 'package:angular2/core.dart';
import 'package:todo_app/ui_channel/ui_channel.dart'
    show Action, Controller, Router;
import 'package:todo_app/module/todo_list/actions.dart' as a;
import 'package:todo_app/module/todo_list/controller/controller.dart';

@Injectable()
class TodoListRouter implements Router {
  UserAddedTodo userAddedTodo;
  UserUpdatedText userUpdatedText;
  UserUpdatedCompletion userUpdatedCompletion;
  UserRemovedTodo userRemovedTodo;
  UserChangedVisibilityFilter userChangedVisibilityFilter;
  TodoListRouter(
      this.userAddedTodo,
      this.userUpdatedText,
      this.userUpdatedCompletion,
      this.userRemovedTodo,
      this.userChangedVisibilityFilter);
  Controller call(Action action) {
    // TODO: It might better to use reflection instead of this switch statement.
    switch (action.runtimeType) {
      case a.UserAddedTodo:
        return userAddedTodo;
      case a.UserUpdatedText:
        return userUpdatedText;
      case a.UserUpdatedCompletion:
        return userUpdatedCompletion;
      case a.UserRemovedTodo:
        return userRemovedTodo;
      case a.UserChangedVisibilityFilter:
        return userChangedVisibilityFilter;
      default:
        throw new ArgumentError('Unknown Action: $action');
    }
  }
}