import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme{
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFF181818),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF15B86C),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFF282828),
        filled: true,
        hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
        contentPadding:
        EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16))
          )
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF181818),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF15B86C),
        unselectedItemColor: Color(0xFFC6C6C6),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFFC6C6C6),
          fontSize: 16,
        ),
        selectedLabelStyle: TextStyle(
            color: Color(0xFF15B86C),
            fontSize: 16
        )

      ),



      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          color: Colors.white,
          fontSize: 16,
        )
      )
    );
  }
}