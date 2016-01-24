library todo_app.todo_store;

import "dart:html";
import "dart:convert";
import "package:angular2/angular2.dart";
import "package:uuid/uuid.dart";

class TodoItem {
  static final uuidGenerator = new Uuid();
  final String uuid;
  String text = '';
  bool isCompleted = false;

  TodoItem([this.text]) : this.uuid = uuidGenerator.v4();

  TodoItem.fromLocalStorage(Map<String, dynamic> data)
      : this.uuid = data['uuid'],
        this.text = data['text'],
        this.isCompleted = data['isCompleted'];

  Map toJsonEncodable() =>
      {'uuid': this.uuid, 'text': this.text, 'isCompleted': this.isCompleted};
}

@Injectable()
class TodoStore {
  List<TodoItem> items;

  TodoStore() {
    final s = window.localStorage['todoList'] ?? '[]';
    this.items = JSON
        .decode(s)
        .map((Map data) => new TodoItem.fromLocalStorage(data))
        .toList();
  }

  void addItem(String newItem) {
    this.items.add(new TodoItem(newItem));
    this.saveToLocalStorage();
  }

  void updateText(String uuid, String updatedText) {
    _findTodoItem(uuid).text = updatedText;
    this.saveToLocalStorage();
  }

  void updateCompletion(String uuid, bool isCompleted) {
    _findTodoItem(uuid).isCompleted = isCompleted;
    this.saveToLocalStorage();
  }

  void removeItem(String uuid) {
    this.items.removeWhere((TodoItem item) => item.uuid == uuid);
    this.saveToLocalStorage();
  }

  void saveToLocalStorage() {
    window.localStorage['todoList'] = JSON
        .encode(items.map((TodoItem item) => item.toJsonEncodable()).toList());
  }

  TodoItem _findTodoItem(String uuid) =>
      this.items.firstWhere((TodoItem item) => item.uuid == uuid);
}
