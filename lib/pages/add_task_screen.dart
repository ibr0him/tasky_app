import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/components/text_input_field_container.dart';

class AddTaskScreen extends StatefulWidget {
   const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final GlobalKey<FormState> _taskNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _taskDescKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                  "Create A Task For Today",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 50),
              TextInputFieldContainer(
                  hintText: 'Finish UI design for login screen',
                  controller: taskNameController,
                  Label: 'Task Name',
                  key: _taskNameKey,
              ),
              SizedBox(height: 20),
              TextInputFieldContainer(
                hintText: 'Finish onboarding UI and hand off to devs by Thursday.',
                controller: taskDescController,
                Label: 'Task Description',
                key: _taskDescKey,
                maxlines: 5,
              ),
              SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  'High Priority',
                  style:Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 20
                  )
                ),
                trailing: Switch(
                    value: true,
                    onChanged: (bool value){},

                ),
              ),
              SizedBox(height: 100),
              ElevatedButton.icon(
                  onPressed:(){},
                icon: Icon(Icons.add),
                label: Text("Add New Task"),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(343, 40)
                )
              )
            ],
          ),
        ),
      )),
    );
  }
}
