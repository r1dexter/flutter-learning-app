import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const FlutterLearningApp());
}

class FlutterLearningApp extends StatelessWidget {
  const FlutterLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа №1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      home: const HomeScreen(),
    );
  }
}
