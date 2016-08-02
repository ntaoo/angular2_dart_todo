import 'todo_list.dart';
import 'package:todo_app/ui_channel/ui_channel.dart' show State;

class AppState extends State {
  TodoList todoList = new TodoList();
  String visibilityFilter = 'SHOW ALL';
}
