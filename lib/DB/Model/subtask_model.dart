import 'package:hive_flutter/adapters.dart';
part 'subtask_model.g.dart';

@HiveType(typeId: 2)
class SubTaskModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String? detail;

  @HiveField(3)
  bool isCompleted;

  SubTaskModel(
      {this.id, required this.title, this.detail, required this.isCompleted});
}
