import 'package:flutter_todo_app/DB/Model/task_model.dart';

sortTask(List<TaskModel> task) {
  task.sort((a, b) => a.date.compareTo(b.date));
}
