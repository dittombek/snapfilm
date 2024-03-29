import 'package:flutter/material.dart';
import 'package:snapfilm/home/home_page.dart';
import 'package:snapfilm/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapFilm',
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
