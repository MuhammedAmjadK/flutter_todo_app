import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ToDo',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
