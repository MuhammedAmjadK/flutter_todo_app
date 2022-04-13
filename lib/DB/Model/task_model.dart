import 'package:flutter_todo_app/DB/Model/subtask_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String category;

  // @HiveField(4)
  // List<SubTaskModel>? subTask;

  TaskModel({
    this.id,
    required this.date,
    required this.title,
    required this.category,
  });
}
