import 'package:flutter/material.dart';

import '../../models/clothing_item.dart';
import '../../services/api_service.dart';
import '../../widgets/clothing_card.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() =>
      _WardrobeScreenState();
}

class _WardrobeScreenState
    extends State<WardrobeScreen> {

  late Future<List<dynamic>> clothingFuture;

  @override
  void initState() {
    super.initState();

    clothingFuture = ApiService.getClothing();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wardrobe'),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: clothingFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No clothing items yet'));
          }

          final clothes = snapshot.data!
              .map((json) => ClothingItem.fromJson(json))
              .toList();

          if (clothes.isEmpty) {
            return const Center(child: Text('No clothing items yet'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: clothes.length,
            itemBuilder: (context, index) {
              return ClothingCard(item: clothes[index]);
            },
          );
        },
      ),
    );
  }
}