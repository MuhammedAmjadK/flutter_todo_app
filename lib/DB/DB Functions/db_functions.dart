// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);

void addTask(TaskModel task) {
  taskListNotifier.value.add(task);
  refreshUI();
}

void deleteTask(TaskModel task) {
  taskListNotifier.value.remove(task);
  refreshUI();
}

refreshUI() {
  taskListNotifier.notifyListeners();
}
