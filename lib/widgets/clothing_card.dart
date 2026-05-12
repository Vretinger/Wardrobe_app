import 'package:flutter/material.dart';

import '../models/clothing_item.dart';

class ClothingCard extends StatelessWidget {

  final ClothingItem item;

  const ClothingCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Image.network(
              item.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(item.category),
                Text(item.color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}