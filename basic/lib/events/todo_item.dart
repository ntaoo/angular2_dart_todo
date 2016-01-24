library events.todo_item;

class TextUpdated {
  final String uuid;
  final String text;
  const TextUpdated(this.uuid, this.text);
}

class IsCompletedUpdated {
  final String uuid;
  final bool isCompleted;
  const IsCompletedUpdated(this.uuid, this.isCompleted);
}