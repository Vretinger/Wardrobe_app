import 'package:flutter/material.dart';

import '../../models/trip.dart';
import '../../services/api_service.dart';
import '../wardrobe/packing_list_screen.dart';
import 'create_trip_screen.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() =>
      _TripsScreenState();
}

class _TripsScreenState
    extends State<TripsScreen> {

  late Future<List<dynamic>> tripsFuture;

  @override
  void initState() {
    super.initState();

    loadTrips();
  }

  void loadTrips() {

    tripsFuture = ApiService.getTrips();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Trips'),
      ),

      floatingActionButton:
          FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
                  const CreateTripScreen(),
            ),
          );

          setState(() {
            loadTrips();
          });
        },
      ),

      body: FutureBuilder<List<dynamic>>(

        future: tripsFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final trips = snapshot.data!
              .map((json) =>
                  Trip.fromJson(json))
              .toList();

          if (trips.isEmpty) {

            return const Center(
              child: Text(
                'No trips yet',
              ),
            );
          }

          return ListView.builder(

            padding:
                const EdgeInsets.all(12),

            itemCount: trips.length,

            itemBuilder: (context, index) {

              final trip = trips[index];

              return Card(

                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),

                child: Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        trip.destination,

                        style:
                            const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Text(
                        '${trip.startDate} → ${trip.endDate}',
                      ),

                      const SizedBox(
                          height: 10),

                      Text(
                        trip.activities,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(

                          child: const Text(
                            'Generate Packing List',
                          ),

                          onPressed: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (_) =>
                                    PackingListScreen(
                                  tripId: trip.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}