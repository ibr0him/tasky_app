import 'package:flutter/material.dart';
import 'package:tasky_app/core/models/users.dart';
import 'package:tasky_app/core/themes/theme.dart';
import 'package:tasky_app/pages/landing_screen.dart';
import 'package:tasky_app/pages/navbar_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Users.display();
  await Users.getFromLocalStorage();
  Users.display();
  print("Karmalla25");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky App',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Users.isSignedin ? const NavbarScreen() : LandingScreen()
    );
  }
}


