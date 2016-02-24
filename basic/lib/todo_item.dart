library todo_app.todo_item;

import "dart:html";
import "dart:async";
import "package:angular2/angular2.dart";
import "./todo_store.dart" as model show TodoItem;
import "./events/todo_item.dart";

@Component(
    selector: 'todo-item',
    templateUrl: './todo_item.html',
    styleUrls: const ['./todo_item.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class TodoItem {
  bool editMode = false;

  @Input()
  model.TodoItem item;

  @Output()
  EventEmitter<model.TodoItem> done = new EventEmitter<model.TodoItem>();

  @Output()
  EventEmitter<TextUpdated> textUpdated = new EventEmitter<TextUpdated>();

  @Output()
  EventEmitter<IsCompletedUpdated> isCompletedUpdated =
      new EventEmitter<IsCompletedUpdated>();

  doneClicked() {
    this.done.add(this.item);
  }

  toggle() {
    this
        .isCompletedUpdated
        .add(new IsCompletedUpdated(this.item.uuid, !this.item.isCompleted));
  }

  enterEditMode(InputElement element) {
    this.editMode = true;
    new Future(() => element.focus());
  }

  cancelEdit(InputElement element) {
    this.editMode = false;
    element.value = this.item.text;
  }

  commitEdit(String updatedText) {
    this.editMode = false;
    this.textUpdated.add(new TextUpdated(this.item.uuid, updatedText));
  }
}
