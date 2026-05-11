import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class PackingListScreen extends StatefulWidget {

  final int tripId;

  const PackingListScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<PackingListScreen> createState() =>
      _PackingListScreenState();
}

class _PackingListScreenState
    extends State<PackingListScreen> {

  late Future<Map<String, dynamic>>
      packingFuture;

  @override
  void initState() {
    super.initState();

    packingFuture =
        ApiService.getPackingList(
      widget.tripId,
    );
  }

  Widget buildSection(
  String title,
  List<dynamic> items,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 16),

    child: Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),

              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 18),
                  const SizedBox(width: 10),
                  Text(item.toString()),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Packing List'),
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: packingFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          final data = snapshot.data!;

          // 🔥 DEBUG OUTPUT (THIS IS THE CORRECT PLACE)
          print(data);

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [

              // temporary debug view in UI
              Text(
                data.toString(),
                style: const TextStyle(fontSize: 12),
              ),

              const SizedBox(height: 20),

              Text(
                data['trip'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text('${data['days']} day trip'),

              const SizedBox(height: 20),

              // FORECAST
              if ((data['forecast'] ?? []).isNotEmpty)
                Column(
                  children: (data['forecast'] as List)
                      .map((forecast) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.cloud),
                        title: Text(
                          '${forecast['temperature']}°C',
                        ),
                        subtitle: Text(
                          forecast['description'],
                        ),
                        trailing: Text(
                          forecast['datetime']
                              .toString()
                              .substring(5, 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              buildSection('Shirts', data['shirts']),
              buildSection('Pants', data['pants']),
              buildSection('Shoes', data['shoes']),
              buildSection('Jackets', data['jackets']),
            ],
          );
        },
      ),
    );
  }
}