import "package:uuid/uuid.dart";

class TodoItem {
  static final Function _generateId = new _UuidGenerator();
  final String id;
  String text;
  bool isCompleted;
  TodoItem.uuid([this.text = '', this.isCompleted = false])
      : this.id = _generateId();
  TodoItem(this.id, [this.text = '', this.isCompleted = false]);
}

class _UuidGenerator {
  static final _uuid = new Uuid();
  String call() => _uuid.v4();
}
