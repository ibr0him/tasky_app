
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/models/task.dart';
import 'package:tasky_app/core/models/user.dart';

class Users {

  static User? currentUser;
  static List<User> _usersData=[];

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
        if(item == person)
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
      currentUser!.tasks.add(userNewTask);

      //Update user info in usersData
      for (var item in _usersData) {
        if(item.fullName == currentUser!.fullName)
        {
          item.tasks=currentUser!.tasks;
        }
      }
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
      currentUser!.tasks.add(userNewTask);

      //Update user info in usersData
      for (var item in _usersData) {
        if(item.fullName == currentUser!.fullName)
        {
          item.tasks=currentUser!.tasks;
        }
      }
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

  static Future<void> clearLocalStorage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usersDataStorage');
  }

  static void display(){
    print("Current User Is $currentUser");
    print("Users Data :-");
    for (var value in _usersData) {
      value.display();
    }
  }

  static Future<void> setLocalStorage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('usersDataStorage');
    await prefs.setString('usersDataStorage', jsonEncode(Users.toMap()));

  }
  static Future<void> getFromLocalStorage() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
     String? data = prefs.getString('usersDataStorage');
     if(data != null)
       { Users.fromMap(jsonDecode(data)); }
     Users.display();
  }

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