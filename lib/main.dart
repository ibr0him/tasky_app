import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/core/theme/dark_theme.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';
import 'package:tasky_app/features/profile/user_controller.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

import 'features/home/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  ThemeController().init();

  String? username = PreferencesManager().getString(StorageKey.username);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskController()..init()),
      ChangeNotifierProvider(create: (_) => UserController()..loadUserData()),
    ],

      child: MyApp(username: username)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}

