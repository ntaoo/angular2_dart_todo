import 'package:test/test.dart';
import 'package:todo_app/module/todo_list/model/data/todo.dart';

main() {
  test('new todo', () {
    var id = 'some id';
    var text = '';
    var isCompleted = false;
    var todo = new Todo(id);
    expect(todo.id, id);
    expect(todo.text, text);
    expect(todo.isCompleted, isCompleted);
  });
}