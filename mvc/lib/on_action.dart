import "dart:async";

import "package:angular2/angular2.dart";

import "actions.dart";
import "model/todo_list.dart";
import "repository/todo_list_storage.dart";

@Injectable()
class OnAction {
  TodoList todoList;
  TodoListStorage todoListStorage;
  OnAction(this.todoList, this.todoListStorage);
  Future call(Action action) async {
    // switch(action.runtimeType) with Type will cause error on `pub build`
    // -> 'case' expression type 'TypeImpl' overrides 'operator =='.
    // Might be related to https://github.com/dart-lang/sdk/issues/23852
    switch (action.actionType) {
      case 'UserAddedTodo':
        UserAddedTodo userAddingTodo = action;
        todoList.add(userAddingTodo.text);
        todoListStorage.save(todoList.items);
        break;
      case 'UserRemovedTodo':
        UserRemovedTodo userRemovingTodo = action;
        todoList.remove(userRemovingTodo.id);
        todoListStorage.save(todoList.items);
        break;
      case 'UserUpdatedText':
        UserUpdatedText userUpdatingText = action;
        todoList.updateText(userUpdatingText.id, userUpdatingText.text);
        todoListStorage.save(todoList.items);
        break;
      case 'UserUpdatedCompletion':
        UserUpdatedCompletion userUpdatingCompletion = action;
        todoList.updateCompletion(
            userUpdatingCompletion.id, userUpdatingCompletion.isCompleted);
        todoListStorage.save(todoList.items);
        break;
      case 'UserLaunchedApp':
        todoList.items = await todoListStorage.load();
        break;
    }
  }
}
