/// Action is an Event like DTO between external system and internal system.
/// Every subclass should have only final fields, and should not have any methods.
abstract class Action {
  const Action();
  String get actionType => runtimeType.toString();
  Map get payload;
  String toString() =>
      {"action": actionType, "payload": payload}.toString();

  // get _payload => _fieldToMap();
  // _fieldToMap with dart:mirrors will need Reflectable package not to kill tree shaking.
  // Some json serializable libraries may help.
  // https://github.com/google/built_json.dart
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
