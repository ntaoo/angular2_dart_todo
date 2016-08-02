import 'dart:async';
import "package:angular2/angular2.dart";
import "package:todo_app/component/intent.dart";
import "package:todo_app/component/todo_item_component.dart";
import "package:todo_app/model/use_case/action_context.dart";
import "package:todo_app/model/use_case/todo_list/actions.dart";
import "package:todo_app/model/domain/app_state.dart";
import "package:todo_app/model/domain/todo_list.dart";
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
      const Provider(ActionContext, useClass: ActionContext),
      const Provider(UIChannel,
          useFactory: uiChannelFactory, deps: const [AppState, ActionContext]),
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

  void removeTodo(UserRemovedTodo event) {
    _intent.removeTodo(event.id);
  }

  void updateText(UserUpdatedText event) {
    if (event.text.isEmpty) {
      _intent.removeTodo(event.id);
    } else {
      _intent.updateText(event.id, event.text);
    }
  }

  void updateCompletion(UserUpdatedCompletion event) {
    _intent.updateCompletion(event.id, event.isCompleted);
  }
}
