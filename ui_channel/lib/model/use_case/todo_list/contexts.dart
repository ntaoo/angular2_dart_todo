import 'dart:async';
import 'package:todo_app/ui_channel/ui_channel.dart' show Context;

import '../../domain/app_state.dart';
import '../../domain/uuid_generator.dart';
import '../../domain/visibility_filter.dart';
import 'actions.dart' as action;

class UserAddedTodo extends Context {
  final action.UserAddedTodo action;
  UserAddedTodo(this.action);
  // TODO: call Stream<action.UserAddedTodo> -> Stream<AppState> maybe better?
  Future<AppState> call(AppState appState) {
    appState.todoList.addTodo(generateUuid(), action.text);
    return new Future.value(appState);
  }
}

class UserUpdatedText extends Context {
  final action.UserUpdatedText action;
  UserUpdatedText(this.action);
  Future<AppState> call(AppState appState) {
    appState.todoList.updateText(action.id, action.text);
    return new Future.value(appState);
  }
}

class UserUpdatedCompletion extends Context {
  final action.UserUpdatedCompletion action;
  UserUpdatedCompletion(this.action);
  Future<AppState> call(AppState appState) {
    appState.todoList.updateCompletion(action.id, action.isCompleted);
    return new Future.value(appState);
  }
}

class UserRemovedTodo extends Context {
  final action.UserRemovedTodo action;
  UserRemovedTodo(this.action);
  Future<AppState> call(AppState appState) {
    appState.todoList.remove(action.id);
    return new Future.value(appState);
  }
}

class UserChangedVisibilityFilter extends Context {
  final action.UserChangedVisibilityFilter action;
  UserChangedVisibilityFilter(this.action);
  Future<AppState> call(AppState appState) {
    if (VisibilityFilter.options.contains(action.filter)) {
      appState.visibilityFilter = action.filter;
    }
    return new Future.value(appState);
  }
}
