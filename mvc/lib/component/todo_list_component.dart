import "package:angular2/angular2.dart";
import "package:todo_app/intent.dart";
import "package:todo_app/events.dart";
import "package:todo_app/model/todo_list.dart";
import "package:todo_app/component/todo_item_component.dart";

// For DI on this root component.
import 'package:todo_app/action_dispatcher.dart';
import 'package:todo_app/on_action.dart';
import 'package:todo_app/repository/todo_list_storage.dart';

@Component(
    selector: 'todo-list',
    templateUrl: './todo_list.html',
    styleUrls: const [
      './todo_list.css'
    ],
    providers: const [
      const Provider(TodoList, useClass: TodoList),
      const Provider(TodoListStorage, useClass: TodoListStorage),
      const Provider(OnAction,
          useClass: OnAction, deps: const [TodoList, TodoListStorage]),
      const Provider(ActionDispatcher,
          useClass: ActionDispatcher, deps: const [OnAction]),
      const Provider(Intent, useClass: Intent, deps: const [ActionDispatcher])
    ],
    directives: const [
      TodoItemComponent,
      CORE_DIRECTIVES,
      FORM_DIRECTIVES
    ])
class TodoListComponent {
  TodoList todoList;
  String newItem = 'test';
  Intent _intent;

  TodoListComponent(this.todoList, this._intent) {
    _intent.launchApp();
  }

  void addTodo() {
    _intent.addTodo(newItem);
    this.newItem = '';
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
