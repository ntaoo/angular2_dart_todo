//import 'dart:mirrors';

abstract class Action {
  String get actionType => runtimeType.toString();
  const Action();
  void dump();
  // dump method with dart:mirrors will need Reflectable package not to kill tree shaking.
//  void dump() {
//    print({"action": runtimeType, "payload": _fieldToMap()});
//  }
//  Map _fieldToMap() {
//    InstanceMirror instanceMirror = reflect(this);
//    Map dataMapped = new Map();
//    for (var declaration in instanceMirror.type.declarations.values) {
//      if (declaration is VariableMirror) {
//        String variableName = MirrorSystem.getName(declaration.simpleName);
//        String variableValue =
//            instanceMirror.getField(declaration.simpleName).reflectee;
//        dataMapped[variableName] = variableValue;
//      }
//    }
//    return dataMapped;
//  }
}

class UserAddedTodo extends Action {
  final String text;
  const UserAddedTodo(this.text);
  void dump() {
    print({
      "action": runtimeType,
      "payload": {"text": text}
    });
  }
}

class UserUpdatedCompletion extends Action {
  final String id;
  final bool isCompleted;
  const UserUpdatedCompletion(this.id, this.isCompleted);
  void dump() {
    print({
      "action": runtimeType,
      "Payload": {"id": id, "isCompleted": isCompleted}
    });
  }
}

class UserRemovedTodo extends Action {
  final String id;
  const UserRemovedTodo(this.id);
  void dump() {
    print({
      "action": runtimeType,
      "payload": {"id": id}
    });
  }
}

class UserUpdatedText extends Action {
  final String id;
  final String text;
  const UserUpdatedText(this.id, this.text);
  void dump() {
    print({
      "action": runtimeType,
      "payload": {"id": id, "text": text}
    });
  }
}

class UserLaunchedApp extends Action {
  const UserLaunchedApp();
  void dump() {
    print({"action": runtimeType, "payload": {}});
  }
}