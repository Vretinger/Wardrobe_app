import 'package:flutter/material.dart';

import '/screens/add_clothing/add_clothing_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/trips/trips_screen.dart';
import '/screens/wardrobe/wardrobe_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const WardrobeScreen(),
    const AddClothingScreen(),
    const TripsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Wardrobe',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: 'Trips',
          ),
        ],
      ),
    );
  }
}