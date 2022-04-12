import 'package:flutter_todo_app/Widgets/task_tile.dart';

List<TaskTile> taskList = [];

DateTime selectedDate = DateTime.now();

List<String> categoryList = [
  "Work",
  "Personal",
  "Whishlist",
  "Project",
  "Goal",
  "Do Soon",
  "Do on Freetime",
];

String? selectedCategory;
