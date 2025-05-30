import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/core/models/users.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/Images/Logo.svg',width: 100),
            Text("Welcome,${Users.currentUser?.fullName}",style: TextStyle(color: Colors.white,
            fontSize: 30),),
            ElevatedButton(onPressed: (){
              Users.clearLocalStorage();
            }, child: Text("Press ME "))
          ],
        ),
      )
    );
  }
}
