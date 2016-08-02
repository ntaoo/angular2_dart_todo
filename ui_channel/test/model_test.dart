import 'package:async/async.dart';
import 'package:test/test.dart';
import 'package:todo_app/ui_channel/ui_channel.dart';
import 'package:todo_app/model/use_case/todo_list/actions.dart';
import 'package:todo_app/model/use_case/action_context.dart';
import 'package:todo_app/model/domain/app_state.dart';

void main() {
  AppState appState;
  StreamQueue<AppState> queue;
  Dispatcher dispatcher;

  setUp(() async {
    appState = new AppState();
    UIChannel uiChannel = uiChannelFactory(appState, new ActionContext());
    dispatcher = new Dispatcher(uiChannel.sink, false);
    queue = new StreamQueue<AppState>(uiChannel.stream);
  });

  test("should create a new todo.", () async {
    dispatcher
      ..dispatch(new UserAddedTodo('first'))
      ..dispatch(new UserAddedTodo('second'));
    expect((await queue.next).todoList.first.text, 'first');
    expect((await queue.next).todoList[1].text, 'second');
  });

  test('should update a todo text.', () async {
    dispatcher
      ..dispatch(new UserAddedTodo('first'))
      ..dispatch(new UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new UserUpdatedText(id, '2'));
    var state2 = await queue.next;
    expect(state2.todoList.firstWhere((t) => t.id == id).text, '2');
    expect(state2.todoList.firstWhere((t) => t.id != id).text, 'first');
  });

  test('should update a todo completion.', () async {
    dispatcher
      ..dispatch(new UserAddedTodo('first'))
      ..dispatch(new UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new UserUpdatedCompletion(id, true));
    var state2 = await queue.next;
    expect(state2.todoList.firstWhere((t) => t.id == id).isCompleted, isTrue);
    expect(state2.todoList.firstWhere((t) => t.id != id).isCompleted, isFalse);
  });

  test('should remove a todo.', () async {
    dispatcher
      ..dispatch(new UserAddedTodo('first'))
      ..dispatch(new UserAddedTodo('second'));
    await queue.next;
    var state = await queue.next;
    var id = state.todoList[1].id;
    dispatcher.dispatch(new UserRemovedTodo(id));
    var state2 = await queue.next;
    expect(state2.todoList.length, 1);
    expect(state2.todoList.firstWhere((t) => t.id != id).text, 'first');
  });

  test("should change visibility filter.", () async {
    dispatcher.dispatch(new UserChangedVisibilityFilter('SHOW ACTIVE'));
    expect((await queue.next).visibilityFilter, 'SHOW ACTIVE');
  });

  test("should not change visibility filter with invalid value.", () async {
    dispatcher.dispatch(new UserChangedVisibilityFilter('SHOW ACTIVEE'));
    expect((await queue.next).visibilityFilter, 'SHOW ALL');
  });
}
