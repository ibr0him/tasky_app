

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/pages/completed_tasks_screen.dart';
import 'package:tasky_app/pages/home_screen.dart';
import 'package:tasky_app/pages/profile_screen.dart';
import 'package:tasky_app/pages/todo_screen.dart';

class NavbarScreen extends StatefulWidget {
   const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _currentIndex = 0;
  List<Widget> screens =[
    HomeScreen(),
    TodoScreen(),
    CompletedTasksScreen(),
    ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index){
          if(index != null)
            {
              setState(() {
                _currentIndex=index;
              });
            }
          // Icons.more_vert
        },
        items: [
          _buildNavItem('assets/Images/HomeIcon.svg', 'Home', 0),
          _buildNavItem('assets/Images/ToDo Icon.svg', 'To Do', 1),
          _buildNavItem('assets/Images/CompletedIcon.svg', 'Completed', 2),
          _buildNavItem('assets/Images/ProfileIcon.svg', 'Profile', 3),

      ]),
      body: screens[_currentIndex]
    );
  }
  // manually setting Icon Style
  BottomNavigationBarItem _buildNavItem(String asset, String label, int index) {
    final isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          SvgPicture.asset(
            asset,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(
              isSelected ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
      label: label,
    );
  }
}

