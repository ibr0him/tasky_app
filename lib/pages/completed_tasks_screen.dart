
import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Text(
                "CompletedTasks Screen Works",
                style: Theme.of(context).textTheme.displayLarge
            ),
          )
      ),
    );
  }
}
