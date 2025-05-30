import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Text(
                "Profile Screen Works",
                style: Theme.of(context).textTheme.displayLarge
            ),
          )
      ),
    );
  }
}
