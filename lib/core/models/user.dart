
import 'package:tasky_app/core/models/task.dart';

class User{
  int? userId;
  String fullName='';
  List<Task> tasks=[];

  User(this.fullName, {this.userId, List<Task>? tasks}) : tasks = tasks ?? [];

  void display(){
    print("User Is $fullName, ID:$userId, Has ${tasks.length} Tasks:-");
    for (var value in tasks) {
      print("\t\t Task${value.id! + 1} --> ID:${value.id}, Title:${value.title}, Des:${value.description}, HP:${value.highPriority}, IsDone: ${value.isDone}");
    }
  }
  @override
  String toString() {
    return "User Is $fullName, ID:$userId, Has ${tasks.length} Tasks";
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) { return true;} //Shortcut for same object ref

    return other is User && other.fullName == fullName;
  }
  @override
  int get hashCode => fullName.hashCode ^ userId.hashCode ^ tasks.hashCode;

  User copy() => User(fullName);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['fullName'] ?? '',
      userId: map['userId'],
      tasks: (map['tasks'] as List<dynamic>?)
          ?.map((taskMap) => Task.fromMap(taskMap))
          .toList() ?? [],
    );
  }
}
