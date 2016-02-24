import "dart:async";

import "package:angular2/angular2.dart";
import "package:todo_app/model/todo_item.dart";

import "src/todo_list_storage_impl.dart";

@Injectable()
abstract class TodoListStorage {
  factory TodoListStorage() = TodoListStorageImpl;
  Future<List<TodoItem>> load();
  Future save(List<TodoItem> todoItems);
}
