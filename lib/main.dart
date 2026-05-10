import 'package:flutter/material.dart';

import 'screens/add_clothing_screen.dart';

void main() {
  runApp(const WardrobeApp());
}

class WardrobeApp extends StatelessWidget {
  const WardrobeApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AddClothingScreen(),
    );
  }
}