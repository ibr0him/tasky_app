import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF181818),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF15B86C),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
               SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/Images/Logo.svg', width: 42),
                   SizedBox(width: 16),
                   Text(
                    'Tasky',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
               SizedBox(height: 108),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'Welcome To Tasky',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                   SizedBox(width: 16),
                  SvgPicture.asset('assets/Images/Hand.svg', height: 28),
                ],
              ),
               Padding(
                padding: EdgeInsets.only(top: 15, bottom: 20),
                child: Text(
                  'Your productivity journey starts here.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SvgPicture.asset('assets/Images/MainPhoto.svg', width: 215),
               SizedBox(height: 28),
               SizedBox(
                width: double.infinity,
                child: Text(
                  "Full Name",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: 12, bottom: 24),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF282828),
                    filled: true,
                    hintText: "e.g. Sarah Khalid",
                    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Homepage()),
                    );
                  },
                  child: Text(
                    'Let’s Get Started',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
