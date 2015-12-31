library todo_app.todo_store;

import "package:angular2/angular2.dart";

class TodoItem {
  String _text;

  get text {
    print('getting value for text ${this._text}');
    return this._text;
  }

  set text(String value) {
    this._text = value;
  }

  TodoItem(this._text);
}

@Injectable()
class TodoStore {
  List<TodoItem> items;

  TodoStore() : this.items = [];

  addItem(String newItem) {
    this.items.add(new TodoItem(newItem));
  }

  removeItem(TodoItem item) {
    this.items.remove(item);
  }
}
