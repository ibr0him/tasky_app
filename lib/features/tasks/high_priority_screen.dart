import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

import '../home/home_controller.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);

    final highPriorityTasks = controller.tasks
        .where((t) => t.isHighPriority)
        .toList()
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('High Priority Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TaskListWidget(
          tasks: highPriorityTasks,
          onTap: (value, index) {
            final task = highPriorityTasks[index!];
            final origIndex = controller.tasks.indexWhere((e) => e.id == task.id);
            controller.doneTask(value, origIndex);
          },
          emptyMessage: 'No Task Found',
          onDelete: (id) => controller.deleteTask(id),
          onEdit: () => controller.loadTasks(),
        ),
      ),
    );
  }
}
