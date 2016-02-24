import "package:angular2/angular2.dart";
import "todo_item.dart";

@Injectable()
class TodoList {
  List<TodoItem> items;

  TodoList() : items = [];

  void add(String newItem) {
    items.add(new TodoItem.uuid(newItem, false));
  }

  void updateText(String id, String updatedText) {
    _find(id).text = updatedText;
  }

  void updateCompletion(String id, bool isCompleted) {
    _find(id).isCompleted = isCompleted;
  }

  void remove(String id) {
    items.remove(_find(id));
  }

  TodoItem _find(String id) =>
      items.firstWhere((TodoItem item) => item.id == id);
}
