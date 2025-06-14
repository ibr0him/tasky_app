import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/components/task_list_widget.dart';

import '../home/home_controller.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);

    final todoTasks = controller.tasks.where((t) => !t.isDone).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text('To Do Tasks', style: Theme.of(context).textTheme.labelSmall),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : TaskListWidget(
              tasks: todoTasks,
              onTap: (value, index) {
                final task = todoTasks[index!];
                final origIndex = controller.tasks.indexWhere((e) => e.id == task.id);
                controller.doneTask(value, origIndex);
              },
              emptyMessage: 'No Task Found',
              onDelete: (id) => controller.deleteTask(id),
              onEdit: () => controller.loadTasks(), // ✅ Updated method name
            ),
          ),
        ),
      ],
    );
  }
}
