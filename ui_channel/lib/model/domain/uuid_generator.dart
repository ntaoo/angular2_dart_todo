import "package:uuid/uuid.dart";

final generateUuid = new _UuidGenerator();

class _UuidGenerator {
  static final _uuid = new Uuid();
  String call() => _uuid.v4();
}
