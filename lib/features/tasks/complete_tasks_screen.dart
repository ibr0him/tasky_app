import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';
import '../home/home_controller.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);
    final completeTasks = controller.tasks.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : TaskListWidget(
          tasks: completeTasks,
          onTap: (value, index) {
            final task = completeTasks[index!];
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
