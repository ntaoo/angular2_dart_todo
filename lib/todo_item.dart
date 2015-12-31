library todo_app.todo_item;

import "package:angular2/angular2.dart";
import "./todo_store.dart" as model show TodoItem;

@Component(
    selector: 'todo-item',
    templateUrl: './todo_item.html',
    styleUrls: const ['./todo_item.css'],
    changeDetection: ChangeDetectionStrategy.OnPush)
class TodoItem {
  @Input()
  model.TodoItem item;

  @Output()
  EventEmitter<model.TodoItem> done = new EventEmitter();

  doneClicked() {
    this.done.add(this.item);
  }
}
