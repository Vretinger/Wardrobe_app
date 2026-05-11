import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 60),

            const Text(
              'Wardrobe App',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Plan outfits and trips smarter.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Upcoming Trip',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'No trips planned yet',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}