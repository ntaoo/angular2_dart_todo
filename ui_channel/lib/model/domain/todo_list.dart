import 'dart:collection';
import "todo.dart";

class TodoList extends ListBase {
  List<Todo> _todos;

  TodoList() : _todos = [];

  operator [](int i) => _todos[i];
  operator []=(int i, Todo todo) => _todos[i] = todo;
  int get length => _todos.length;
  set length(int i) => _todos.length = i;

  Iterator get iterator => _todos.iterator;

  void addTodo(String id, String text) {
    _todos.add(new Todo(id, text));
  }

  void updateText(String id, String text) {
    _find(id).text = text;
  }

  void updateCompletion(String id, bool isCompleted) {
    _find(id).isCompleted = isCompleted;
  }

  bool remove(String id) {
    return _todos.remove(_find(id));
  }

  Todo _find(String id) => _todos.firstWhere((Todo item) => item.id == id);
}
