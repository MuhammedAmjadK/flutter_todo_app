import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_app/Colors/colors.dart';
import 'package:flutter_todo_app/DB/DB%20Functions/db_functions.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {Key? key,
      required this.date,
      required this.title,
      required this.category})
      : super(key: key);

  final DateTime date;
  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.shade500,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 30,
                child: Text(
                  "${date.day}/${date.month}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: primaryColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        // color: Colors.green,
                        alignment: Alignment.bottomLeft,
                        child: TaskTileText(
                          text: title,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      // color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: TaskTileText(
                        text: category,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TaskTileActions(
          color: Colors.lightBlue.shade100,
          icon: Icons.star_border,
          onTap: () {},
        ),
      ],
      secondaryActions: [
        TaskTileActions(
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}

class TaskTileActions extends StatelessWidget {
  const TaskTileActions(
      {Key? key, required this.color, required this.icon, required this.onTap})
      : super(key: key);

  final Color color;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.shade500,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(icon),
      ),
      onTap: onTap,
    );
  }
}

class TaskTileText extends StatelessWidget {
  const TaskTileText(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black})
      : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
