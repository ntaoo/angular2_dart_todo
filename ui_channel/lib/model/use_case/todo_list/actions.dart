import 'package:todo_app/ui_channel/ui_channel.dart' show Action;

// TODO: TodoAction extends Action;
// TODO: UserAction extends TodoAction;

class UserAddedTodo extends Action {
  final String text;
  const UserAddedTodo(this.text);
  Map get payload => {"text": text};
}

class UserUpdatedCompletion extends Action {
  final String id;
  final bool isCompleted;
  const UserUpdatedCompletion(this.id, this.isCompleted);
  Map get payload => {"id": id, "isCompleted": isCompleted};
}

class UserRemovedTodo extends Action {
  final String id;
  const UserRemovedTodo(this.id);
  Map get payload => {"id": id};
}

class UserUpdatedText extends Action {
  final String id;
  final String text;
  const UserUpdatedText(this.id, this.text);
  Map get payload => {"id": id, "text": text};
}

class UserChangedVisibilityFilter extends Action {
  final String filter;
  const UserChangedVisibilityFilter(this.filter);
  Map get payload => {"filter": filter};
}
