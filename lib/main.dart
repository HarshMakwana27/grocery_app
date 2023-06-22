import 'package:flutter/material.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: theme,
      darkTheme: darkTheme,
      home: const Homepage(),
      themeMode: ThemeMode.light,
    );
  }
}
