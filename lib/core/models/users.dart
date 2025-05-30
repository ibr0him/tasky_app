
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/models/task.dart';
import 'package:tasky_app/core/models/user.dart';

class Users {

  static User? currentUser;
  static List<User> _usersData=[];
  static SharedPreferences? _prefs;

  static get isSignedin => (currentUser != null);
  static Future<void> addUser(User person) async{
    if(_usersData.isEmpty){
      person.userId=0;
      _usersData.add(person);
      currentUser=person;
      await setLocalStorage();
    }
    else{
      bool newUser=true;
      for (var item in _usersData) {
        if(item.fullName == person.fullName)
        {
          newUser=false;
          currentUser=person;
          await setLocalStorage();
          break;
        }
      }
      if(newUser){
        person.userId=_usersData.length;
        _usersData.add(person);
        currentUser=person;
        await setLocalStorage();
      }

    }
  }
  static Future<bool> addTaskToCurrentUser(Task userNewTask) async{ // returns true if added successfully only
    if(!isSignedin){ return false; }
    if( currentUser!.tasks.isEmpty){
      userNewTask.id=0;
      currentUser!.tasks.add(userNewTask); // Update Current User
      _usersData[currentUser!.userId!].tasks.add(userNewTask); //Update user info in usersData

      //Updating Local Storage
      await setLocalStorage();
      return true;
    }
    if(currentUser!.tasks.isNotEmpty){

      // Already been Added Task
      for (var item in currentUser!.tasks) {
        if(item == userNewTask){
          return false;
        }
      }

      // Update Current User info
      userNewTask.id = currentUser!.tasks.length;
      currentUser!.tasks.add(userNewTask); // Update Current User
      _usersData[currentUser!.userId!].tasks.add(userNewTask); //Update user info in usersData

      await setLocalStorage();
      return true;
    }
    return false;
  }
  static Future<void> signOut() async{
    if(!isSignedin){return;}
    {
      currentUser = null;
      await setLocalStorage();
    }
  }

  static void display(){
    print("Current User Is $currentUser");
    print("Users Data :-");
    for (var value in _usersData) {
      value.display();
    }
  }

  // Getters
  static List<Task>? getAllTasks(){
    return _usersData[currentUser!.userId!].tasks;
  }
  static List<Task>? getTodoTasks(){
    return _usersData[currentUser!.userId!].tasks.where((item) => item.isDone ==false).toList();
  }
  static List<Task>? getCompletedTasks(){
    return _usersData[currentUser!.userId!].tasks.where((item) => item.isDone ==true).toList();
  }
  static List<Task>? getHighPriorityTasks(){
    return _usersData[currentUser!.userId!].tasks.where((item) => item.highPriority ==true).toList();
  }


  // LocalStorage Operations
  static Future<void> initLocalStorage() async{
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<void> setLocalStorage() async{
    await _prefs!.remove('usersDataStorage');
    await _prefs!.setString('usersDataStorage', jsonEncode(Users.toMap()));
  }
  static getFromLocalStorage(){
     String? data = _prefs!.getString('usersDataStorage');
     if(data != null)
       { Users.fromMap(jsonDecode(data)); }
  }
  static Future<void> clearLocalStorage() async{
    await _prefs!.remove('usersDataStorage');
  }

  // From-Map And To-Map Converting
  static Map<String, dynamic> toMap() {
    return {
      'currentUser': currentUser?.toMap(),
      'usersData': _usersData.map((user) => user.toMap()).toList(),
    };
  }
  static void fromMap(Map<String, dynamic> map) {
    currentUser = map['currentUser'] != null ? User.fromMap(map['currentUser']) : null;
    _usersData = (map['usersData'] as List<dynamic>?)
        ?.map((userMap) => User.fromMap(userMap))
        .toList() ?? [];
  }
}