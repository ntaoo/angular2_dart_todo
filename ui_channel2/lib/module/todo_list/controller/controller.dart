import 'dart:async';
import 'package:angular2/core.dart';
import 'package:todo_app/ui_channel/ui_channel.dart' show State, Controller;
import 'package:todo_app/module/todo_list/actions.dart' as action;
import 'package:todo_app/module/todo_list/model/src/uuid_generator.dart';
import 'package:todo_app/module/todo_list/model/data/app_state.dart';
import 'package:todo_app/module/todo_list/model/data/visibility_filter.dart';

const List controllerProviders = const [
  UuidGenerator,
  const Provider(UserAddedTodo, useClass: UserAddedTodo, deps: const [UuidGenerator]),
  UserUpdatedText,
  UserUpdatedCompletion,
  UserRemovedTodo,
  UserChangedVisibilityFilter,
];

@Injectable()
class UserAddedTodo implements Controller {
  UuidGenerator uuidGenerator;
  UserAddedTodo(this.uuidGenerator);
  Future<State> call(AppState appState, action.UserAddedTodo action) {
    appState.todoList.addTodo(uuidGenerator(), action.text);
    return new Future.value(appState);
  }
}

@Injectable()
class UserUpdatedText implements Controller {
  Future<AppState> call(AppState appState, action.UserUpdatedText action) {
    appState.todoList.updateText(action.id, action.text);
    return new Future.value(appState);
  }
}

@Injectable()
class UserUpdatedCompletion implements Controller {
  Future<AppState> call(
      AppState appState, action.UserUpdatedCompletion action) {
    appState.todoList.updateCompletion(action.id, action.isCompleted);
    return new Future.value(appState);
  }
}

@Injectable()
class UserRemovedTodo implements Controller {
  Future<AppState> call(AppState appState, action.UserRemovedTodo action) {
    appState.todoList.remove(action.id);
    return new Future.value(appState);
  }
}

@Injectable()
class UserChangedVisibilityFilter implements Controller {
  Future<AppState> call(
      AppState appState, action.UserChangedVisibilityFilter action) {
    if (VisibilityFilter.options.contains(action.filter)) {
      appState.visibilityFilter = action.filter;
    }
    return new Future.value(appState);
  }
}
