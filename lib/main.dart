import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/home_page.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routeName : (_) => HomePage(),
  },
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.DarkTheme,
  themeMode: ThemeMode.light,
    );
  }
}