import 'action.dart';
import 'controller.dart';

abstract class Router {
  Controller call(Action action);
}