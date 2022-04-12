import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/db_functions.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:flutter_todo_app/Functions/create_task.dart';
import 'package:flutter_todo_app/Parameters/common_parameters.dart';
import 'package:flutter_todo_app/Widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllTask();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ValueListenableBuilder(
          valueListenable: taskListNotifier,
          builder: (BuildContext ctx, List<TaskModel> taskList, _) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final task = taskList[index];
                return TaskTile(
                    id: task.id,
                    date: task.date,
                    title: task.title,
                    category: task.category);
              },
              itemCount: taskList.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectedDate = DateTime.now();
          selectedCategory = null;
          createTask(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
