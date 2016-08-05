import 'package:async/async.dart';
import 'package:test/test.dart';
import 'package:todo_app/ui_channel/ui_channel.dart';
import 'package:todo_app/module/todo_list/controller/controller.dart';
import 'package:todo_app/module/todo_list/actions.dart' as a;
import 'package:todo_app/module/todo_list/router.dart';
import 'package:todo_app/module/todo_list/model/data/app_state.dart';
import 'package:todo_app/module/todo_list/model/src/uuid_generator.dart';

void main() {
  AppState appState;
  StreamQueue<AppState> queue;
  Dispatcher dispatcher;

  setUp(() {
    appState = new AppState();
    var router = new TodoListRouter(
        new UserAddedTodo(new UuidGenerator()),
        new UserUpdatedText(),
        new UserUpdatedCompletion(),
        new UserRemovedTodo(),
        new UserChangedVisibilityFilter());
    UIChannel uiChannel = uiChannelFactory(appState, router);
    dispatcher = dispatcherFactory(uiChannel);
    queue = new StreamQueue<AppState>(uiChannel.stream);
  });

  test("should create a new todo.", () async {
    dispatcher
      ..dispatch(new a.UserAddedTodo('first'))
      ..dispatch(new a.UserAddedTodo('second'));
    expect((await queue.next).todoList.first.text, 'first');
    expect((await queue.next).todoList[1].text, 'second');
  });

  test('should update a todo text.', () async {
    dispatcher
      ..dispatch(new a.UserAddedTodo('first'))
      ..dispatch(new a.UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new a.UserUpdatedText(id, '2'));
    var state2 = await queue.next;
    expect(state2.todoList.firstWhere((t) => t.id == id).text, '2');
    expect(state2.todoList.firstWhere((t) => t.id != id).text, 'first');
  });

  test('should update a todo completion.', () async {
    dispatcher
      ..dispatch(new a.UserAddedTodo('first'))
      ..dispatch(new a.UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new a.UserUpdatedCompletion(id, true));
    var state2 = await queue.next;
    expect(state2.todoList.firstWhere((t) => t.id == id).isCompleted, isTrue);
    expect(state2.todoList.firstWhere((t) => t.id != id).isCompleted, isFalse);
  });

  test('should remove a todo.', () async {
    dispatcher
      ..dispatch(new a.UserAddedTodo('first'))
      ..dispatch(new a.UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new a.UserRemovedTodo(id));
    var state2 = await queue.next;
    expect(state2.todoList.length, 1);
    expect(state2.todoList.firstWhere((t) => t.id != id).text, 'first');
  });

  test("should change visibility filter.", () async {
    dispatcher.dispatch(new a.UserChangedVisibilityFilter('SHOW ACTIVE'));
    expect((await queue.next).visibilityFilter, 'SHOW ACTIVE');
  });

  test("should not change visibility filter with invalid value.", () async {
    dispatcher.dispatch(new a.UserChangedVisibilityFilter('SHOW ACTIVEE'));
    expect((await queue.next).visibilityFilter, 'SHOW ALL');
  });
}
