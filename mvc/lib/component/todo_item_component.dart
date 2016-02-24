import "dart:async";
import "dart:html";

import "package:angular2/angular2.dart";
import "package:todo_app/events.dart";
import "package:todo_app/model/todo_item.dart";

@Component(
    selector: 'todo-item',
    templateUrl: './todo_item.html',
    styleUrls: const ['./todo_item.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class TodoItemComponent {
  bool editMode = false;

  @Input()
  TodoItem item;

  @Output()
  EventEmitter<UserRemovedTodo> userRemovedTodo = new EventEmitter<UserRemovedTodo>();

  @Output()
  EventEmitter<UserUpdatedText> userUpdatedText = new EventEmitter<UserUpdatedText>();

  @Output()
  EventEmitter<UserUpdatedCompletion> userUpdatedCompletion =
      new EventEmitter<UserUpdatedCompletion>();

  void cancelEdit(InputElement element) {
    editMode = false;
  }

  void commitEdit(String updatedText) {
    editMode = false;
    userUpdatedText.add(new UserUpdatedText(item.id, updatedText));
  }

  void doneClicked() {
    userRemovedTodo.add(new UserRemovedTodo(item.id));
  }

  void enterEditMode(InputElement element) {
    editMode = true;
    new Future(() => element.focus());
  }

  void toggle() {
    userUpdatedCompletion.add(new UserUpdatedCompletion(item.id, !item.isCompleted));
  }
}
