import 'dart:async';
import "package:angular2/angular2.dart";
import "package:todo_app/module/todo_list/component/intent.dart";
import "package:todo_app/module/todo_list/component/todo_item_component.dart";

import "package:todo_app/module/todo_list/router.dart";
import "package:todo_app/module/todo_list/actions.dart" as a;
import "package:todo_app/module/todo_list/controller/controller.dart";
import "package:todo_app/module/todo_list/model/data/app_state.dart";
import "package:todo_app/module/todo_list/model/data/todo_list.dart";
import 'package:todo_app/ui_channel/ui_channel.dart';

const APP_STATES = const OpaqueToken("state");

// As BroadcastStream listened in many stateful components.
Stream<AppState> createAppStateStream(UIChannel channel) =>
    channel.stream.asBroadcastStream();

@Component(
    selector: 'todo-list',
    templateUrl: './todo_list.html',
    styleUrls: const [
      './todo_list.css'
    ],
    providers: const [
      const Provider(AppState, useClass: AppState),
      const Provider(TodoListRouter, useClass: TodoListRouter),
      controllerProviders,
      const Provider(UIChannel,
          useFactory: uiChannelFactory, deps: const [AppState, TodoListRouter]),
      const Provider(Dispatcher,
          useFactory: dispatcherFactory, deps: const [UIChannel]),
      const Provider(APP_STATES,
          useFactory: createAppStateStream, deps: const [UIChannel]),
      const Provider(Intent, useClass: Intent, deps: const [Dispatcher])
    ],
    directives: const [
      TodoItemComponent,
      CORE_DIRECTIVES,
      FORM_DIRECTIVES
    ])
class TodoListComponent {
  String newItem = 'test';
  TodoList todoList;
  Intent _intent;
  TodoListComponent(
      this._intent, @Inject(APP_STATES) Stream<AppState> appStates) {
    appStates
        .map((AppState state) => state.todoList)
        .listen((TodoList t) => todoList = t);
  }

  void addTodo() {
    _intent.addTodo(newItem);
    newItem = '';
  }

  void removeTodo(a.UserRemovedTodo event) {
    _intent.removeTodo(event.id);
  }

  void updateText(a.UserUpdatedText event) {
    if (event.text.isEmpty) {
      _intent.removeTodo(event.id);
    } else {
      _intent.updateText(event.id, event.text);
    }
  }

  void updateCompletion(a.UserUpdatedCompletion event) {
    _intent.updateCompletion(event.id, event.isCompleted);
  }
}
