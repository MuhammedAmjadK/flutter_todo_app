import 'package:flutter/material.dart';
import 'package:flutter_todo_app/DB/Model/subtask_model.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<SubTaskModel>> subTaskListNotifier = ValueNotifier([]);

Future addSubTask(TaskModel task, SubTaskModel subTask) async {
  final subTaskDB = await Hive.openBox<SubTaskModel>('${task.id}');
  final id = await subTaskDB.add(subTask);
  subTask.id = id;
  subTaskDB.put(subTask.id, subTask);
  subTaskListNotifier.value.add(subTask);
  refreshUI();
}

Future<void> updateSubTask(
    TaskModel task, SubTaskModel subTask, bool value) async {
  final subTaskDB = await Hive.openBox<SubTaskModel>('${task.id}');
  // subTask.isCompleted = value;
  await subTaskDB.put(subTask.id, subTask);
}

Future<void> deleteSubTask(TaskModel task, int id) async {
  final subTaskDB = await Hive.openBox<SubTaskModel>('${task.id}');
  await subTaskDB.delete(id);
  getAllSubTask(task);
}

Future<void> getAllSubTask(TaskModel task) async {
  final subTaskDB = await Hive.openBox<SubTaskModel>('${task.id}');
  subTaskListNotifier.value.clear();
  subTaskListNotifier.value.addAll(subTaskDB.values);
  refreshUI();
}

refreshUI() {
  subTaskListNotifier.notifyListeners();
}
