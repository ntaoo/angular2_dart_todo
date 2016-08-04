import "dart:async";
import "dart:convert";
import "dart:html";

import "package:todo_app/module/todo_list/model/data/todo.dart";

import "../todo_list_storage.dart";

class TodoListStorageImpl implements TodoListStorage {
  final String _key = 'todoList';

  Future<List<Todo>> load() {
    return new Future.microtask(() {
      var s = window.localStorage[_key] ?? '[]';
      return JSON.decode(s).map(_toTodoItem).toList();
    });
  }

  Future save(List<Todo> todoItems) {
    return new Future.microtask(() {
      window.localStorage[_key] = JSON.encode(todoItems.map(_toMap).toList());
    });
  }

  // Note, automatic object field to Map conversion with dart:mirror will need Reflectable package not to kill tree shaking.
  Map _toMap(Todo item) =>
      {'id': item.id, 'text': item.text, 'isCompleted': item.isCompleted};

  Todo _toTodoItem(Map data) =>
      new Todo(data['id'], data['text'], data['isCompleted']);
}
