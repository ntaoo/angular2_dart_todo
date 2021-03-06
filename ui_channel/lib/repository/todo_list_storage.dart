import "dart:async";

import "package:angular2/angular2.dart";
import "package:todo_app/model/domain/todo.dart";

import "src/todo_list_storage_impl.dart";

@Injectable()
abstract class TodoListStorage {
  factory TodoListStorage() = TodoListStorageImpl;
  Future<List<Todo>> load();
  Future save(List<Todo> todoItems);
}
