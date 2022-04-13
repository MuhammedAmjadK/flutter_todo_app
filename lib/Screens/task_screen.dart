import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/subtask_db_functios.dart';
import 'package:flutter_todo_app/DB/Model/subtask_model.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:flutter_todo_app/Functions/create_subtask.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key, required this.task}) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    getAllSubTask(task);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "  ${task.category}",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "  ${DateFormat('dd-MM-yyyy').format(task.date)}",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 80,
                  child: TextButton(
                    onPressed: () {
                      createSubTask(context, task);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 30,
                        ),
                        Text(
                          "Add Subtasks",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: ValueListenableBuilder(
                valueListenable: subTaskListNotifier,
                builder: (BuildContext ctx, List<SubTaskModel> taskList, _) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final subTask = taskList[index];
                      return SubTaskTile(
                        subTask: subTask,
                        task: task,
                      );
                    },
                    itemCount: taskList.length,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SubTaskTile extends StatefulWidget {
  const SubTaskTile({
    Key? key,
    required this.task,
    required this.subTask,
  }) : super(key: key);

  final TaskModel task;

  final SubTaskModel subTask;

  @override
  State<SubTaskTile> createState() => _SubTaskTileState();
}

class _SubTaskTileState extends State<SubTaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: widget.subTask.isCompleted ? Colors.green : primaryColor,
        ),
      ),
      child: ListTile(
        leading: Checkbox(
          value: widget.subTask.isCompleted,
          onChanged: (value) {
            setState(() {
              widget.subTask.isCompleted = value!;
            });

            updateSubTask(widget.task, widget.subTask, value!);
          },
        ),
        title: Text(
          widget.subTask.title,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration:
                widget.subTask.isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
          ),
        ),
        subtitle: widget.subTask.detail != null
            ? Text(
                widget.subTask.detail!,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                  decoration: widget.subTask.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.green,
                  decorationThickness: 2,
                ),
              )
            : null,
        trailing: IconButton(
            onPressed: () {
              if (widget.subTask.id != null) {
                deleteSubTask(widget.task, widget.subTask.id!);
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }
}
