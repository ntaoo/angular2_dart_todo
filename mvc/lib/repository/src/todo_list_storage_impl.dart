import "dart:async";
import "dart:convert";
import "dart:html";

import "package:todo_app/model/todo_item.dart";

import "../todo_list_storage.dart";

class TodoListStorageImpl implements TodoListStorage {
  final String _key = 'todoList';

  Future<List<TodoItem>> load() {
    return new Future.microtask(() {
      var s = window.localStorage[_key] ?? '[]';
      return JSON.decode(s).map(_toTodoItem).toList();
    });
  }

  Future save(List<TodoItem> todoItems) {
    return new Future.microtask(() {
      window.localStorage[_key] = JSON.encode(todoItems.map(_toMap).toList());
    });
  }

  // Note, automatic object field to Map conversion with dart:mirror will need Reflectable package not to kill tree shaking.
  Map _toMap(TodoItem item) =>
      {'id': item.id, 'text': item.text, 'isCompleted': item.isCompleted};

  TodoItem _toTodoItem(Map data) =>
      new TodoItem(data['id'], data['text'], data['isCompleted']);
}
