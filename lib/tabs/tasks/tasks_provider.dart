import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selecteddate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> alltasks = await FirebaseFunctions.getAllTasks();
    tasks = alltasks
        .where((task) =>
            task.date.day == selecteddate.day &&
            task.date.month == selecteddate.month &&
            task.date.year == selecteddate.year)
        .toList();
    notifyListeners();
  }

  void changeDate(DateTime date) {
    selecteddate = date;
    notifyListeners();
  }
}
