library todo_app.web;

import 'package:angular2/bootstrap.dart';
import "package:todo_app/todo_list.dart";
import 'package:todo_app/todo_store.dart';

main() => bootstrap(TodoList, [TodoStore]);
