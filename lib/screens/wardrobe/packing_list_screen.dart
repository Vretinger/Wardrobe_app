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

          return ListView(
            padding: const EdgeInsets.all(16),

            children: [

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

              Card(
                child: ListTile(
                  title: const Text('Shirts'),
                  trailing: Text(
                    '${data['shirts']}',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Pants'),
                  trailing: Text(
                    '${data['pants']}',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Shoes'),
                  trailing: Text(
                    '${data['shoes']}',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Jackets'),
                  trailing: Text(
                    '${data['jackets']}',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}