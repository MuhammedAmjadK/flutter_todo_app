import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/task_db_functions.dart';
import 'package:flutter_todo_app/DB/Model/task_model.dart';
import 'package:flutter_todo_app/Functions/create_task.dart';
import 'package:flutter_todo_app/Parameters/common_parameters.dart';
import 'package:flutter_todo_app/Widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getAllTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
        backgroundColor: primaryColor,
        bottom: TabBar(controller: _tabController, tabs: [
          tabText("Pending"),
          tabText("Starred"),
          tabText("Completed"),
        ]),
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeScreenBody(
          listenable: pendingTaskListNotifier,
        ),
        HomeScreenBody(
          listenable: starredTaskListNotifier,
        ),
        HomeScreenBody(
          listenable: completedTaskListNotifier,
        ),
      ]),
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

Widget tabText(String tabName) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      tabName,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key, required this.listenable}) : super(key: key);

  final ValueListenable<List<TaskModel>> listenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: listenable,
        builder: (BuildContext ctx, List<TaskModel> taskList, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TaskTile(
                task: taskList[index],
              );
            },
            itemCount: taskList.length,
          );
        });
  }
}
