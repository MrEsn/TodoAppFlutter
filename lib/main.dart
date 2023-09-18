import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotask/models/Category.dart';
import 'package:todotask/models/Task.dart';
import 'package:todotask/screens/createctegory.dart';
import 'package:todotask/screens/createtask.dart';
import 'package:todotask/screens/homeScreen.dart';
import 'package:todotask/screens/mainScreen.dart';
import 'package:todotask/screens/taskScreen.dart';
import 'package:todotask/screens/category.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');
  Hive.registerAdapter(CategoryNaderAdapter());
  await Hive.openBox<CategoryNader>('categoryBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Future<void> getDatatask() async {
    HomeScreen.tasks.clear();
    Box<Task> hiveBox = await Hive.box<Task>('taskBox');
    for (var value in hiveBox.values) {
      HomeScreen.tasks.add(value);
    }
    print(HomeScreen.tasks);
  }

  /* static void getDatacat() {
    HomeScreen.categorys.clear();
   Box<CategoryNader> hiveBox = Hive.box<CategoryNader>('categoryBox');
    for (var value in hiveBox.values) {
      HomeScreen.categorys.add(value);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Nunito'),
        debugShowCheckedModeBanner: false,
        home: MainScreen());
  }
}
