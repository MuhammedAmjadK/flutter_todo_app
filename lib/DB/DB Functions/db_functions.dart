import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<TaskModel>> taskListNotifier = ValueNotifier([]);

Future addTask(TaskModel task) async {
  final taskDB = await Hive.openBox<TaskModel>('task_db');
  final id = await taskDB.add(task);
  task.id = id;
  taskDB.put(task.id, task);
  taskListNotifier.value.add(task);
  refreshUI();
}

Future<void> deleteTask(int id) async {
  final taskDB = await Hive.openBox<TaskModel>('task_db');
  await taskDB.delete(id);
  // taskListNotifier.value.removeWhere((element) => element.id == id);
  // refreshUI();
  getAllTask();
}

Future<void> getAllTask() async {
  final taskDB = await Hive.openBox<TaskModel>('task_db');
  taskListNotifier.value.clear();
  taskListNotifier.value.addAll(taskDB.values);
  refreshUI();
}

refreshUI() {
  taskListNotifier.notifyListeners();
}
