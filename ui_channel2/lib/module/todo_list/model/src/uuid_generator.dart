import "package:uuid/uuid.dart";
import 'package:angular2/core.dart';

@Injectable()
class UuidGenerator {
  final _uuid = new Uuid();
  String call() => _uuid.v4();
}
