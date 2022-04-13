import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/task_db_functions.dart';
import 'package:flutter_todo_app/DB/Model/subtask_model.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:flutter_todo_app/Parameters/common_parameters.dart';
import 'package:intl/intl.dart';

void createTask(BuildContext context) {
  TextEditingController _controller = TextEditingController();
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
                    "Add Task",
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
                    controller: _controller,
                    validator: (value) {
                      return value!.trim().isNotEmpty
                          ? null
                          : 'Enter a task name';
                    },
                    onFieldSubmitted: (_) {
                      formKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                      hintText: "New Task",
                      enabledBorder: customBorder(primaryColor),
                      focusedBorder: customBorder(Colors.black),
                      errorBorder: customBorder(Colors.red),
                      focusedErrorBorder: customBorder(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                          hint: const Text("Category"),
                          value: selectedCategory,
                          items: categoryList.map(buildMenuItem).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }),
                    ),
                    Expanded(
                        child: GestureDetector(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade500,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat('dd-MM-yyyy').format(selectedDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (newDate == null) {
                          return;
                        } else {
                          setState(() {
                            selectedDate = newDate;
                          });
                        }
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        TaskModel task = TaskModel(
                          date: selectedDate,
                          title: _controller.text,
                          category: selectedCategory ?? "Do Soon",
                        );

                        addTask(task);
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

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(item),
  );
}

InputBorder customBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 2,
    ),
  );
}
