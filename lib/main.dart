import 'package:flutter/material.dart';

import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const WardrobeApp());
}

class WardrobeApp extends StatelessWidget {
  const WardrobeApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
            const Color(0xFF121212),
      ),

      home: const MainNavigationScreen(),
    );
  }
}