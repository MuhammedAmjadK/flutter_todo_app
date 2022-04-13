import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/subtask_db_functios.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/task_db_functions.dart';
import 'package:flutter_todo_app/DB/Model/subtask_model.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';

void createSubTask(BuildContext context, TaskModel task) {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    "Add Subtask",
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      return value!.trim().isNotEmpty
                          ? null
                          : 'Enter a task title';
                    },
                    onFieldSubmitted: (_) {
                      formKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      hintText: "Title",
                      enabledBorder: customBorder(primaryColor),
                      focusedBorder: customBorder(Colors.black),
                      errorBorder: customBorder(Colors.red),
                      focusedErrorBorder: customBorder(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _detailsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Description",
                    enabledBorder: customBorder(primaryColor),
                    focusedBorder: customBorder(Colors.black),
                    errorBorder: customBorder(Colors.red),
                    focusedErrorBorder: customBorder(Colors.red),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        SubTaskModel subTask = SubTaskModel(
                          title: _titleController.text,
                          detail: _detailsController.text,
                          isCompleted: false,
                        );

                        addSubTask(task, subTask);
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          );
        });
      });
}

InputBorder customBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 2,
    ),
  );
}
