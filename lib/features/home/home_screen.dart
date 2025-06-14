import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_svg_picture.dart';
import 'package:tasky_app/features/add_task/add_task_screen.dart';
import 'package:tasky_app/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky_app/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky_app/features/home/components/sliver_task_list_widget.dart';

import '../profile/user_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final taskController = context.watch<TaskController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserController>(
                    builder: (context, userController, child) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: userController.userImagePath == null
                                ? const AssetImage('assets/images/person.png')
                                : FileImage(File(userController.userImagePath!)) as ImageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Evening, ${userController.username ?? ''}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                userController.motivationQuote ?? "One task at a time. One step closer.",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Yuhuu, Your work Is',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done!',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      CustomSvgPicture.withoutColor(path: 'assets/images/waving_hand.svg'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const AchievedTasksWidget(),
                  const SizedBox(height: 8),
                  const HighPriorityTasksWidget(),
                  const Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SliverTaskListWidget(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()),
            );
            if (result == true) {
              taskController.loadTasks();
            }
          },
          label: const Text('Add New Task'),
          icon: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
