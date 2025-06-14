import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/models/task_model.dart';

class TaskController with ChangeNotifier {
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  void init() {
    loadTasks();
  }

  void loadTasks() async {
    isLoading = true;
    notifyListeners();

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final decoded = jsonDecode(finalTask) as List<dynamic>;
      tasks = decoded.map((e) => TaskModel.fromJson(e)).toList();
      calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void calculatePercent() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();
    await _saveTasks();
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    await _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  }
}
