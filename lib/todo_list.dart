library todo_app.todo_list;

import "package:angular2/angular2.dart";
import './todo_store.dart' as model;
import './todo_item.dart';
import './events/todo_item.dart';

@Component(
    selector: 'todo-list',
    templateUrl: './todo_list.html',
    styleUrls: const ['./todo_list.css'],
    directives: const [TodoItem, CORE_DIRECTIVES, FORM_DIRECTIVES])
class TodoList {
  String newItem = 'test';
  model.TodoStore store;

  TodoList(this.store);

  addItem() {
    this.store.addItem(this.newItem);
    this.newItem = '';
  }

  removeItem(model.TodoItem item) {
    this.store.removeItem(item.uuid);
  }

  textUpdated(TextUpdated event) {
    if (event.text.isEmpty) {
      this.store.removeItem(event.uuid);
    } else {
      this.store.updateText(event.uuid, event.text);
    }
  }

  isCompletedUpdated(IsCompletedUpdated event) {
    this.store.updateCompletion(event.uuid, event.isCompleted);
  }
}
