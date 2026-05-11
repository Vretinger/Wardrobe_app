import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() =>
      _CreateTripScreenState();
}

class _CreateTripScreenState
    extends State<CreateTripScreen> {

  final destinationController =
      TextEditingController();

  final activitiesController =
      TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickStartDate() async {

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> pickEndDate() async {

    final picked = await showDatePicker(
      context: context,
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2030),
      initialDate:
          startDate ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  Future<void> saveTrip() async {

    if (startDate == null ||
        endDate == null) {
      return;
    }

    try {

      await ApiService.createTrip(
        destination:
            destinationController.text,

        startDate:
            startDate!
                .toIso8601String()
                .split('T')[0],

        endDate:
            endDate!
                .toIso8601String()
                .split('T')[0],

        activities:
            activitiesController.text,
      );

      if (mounted) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text('Trip created!'),
          ),
        );

        Navigator.pop(context);
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Create Trip'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  destinationController,

              decoration:
                  const InputDecoration(
                labelText: 'Destination',
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              title: Text(
                startDate == null
                    ? 'Select Start Date'
                    : startDate.toString()
                        .split(' ')[0],
              ),

              trailing:
                  const Icon(Icons.calendar_month),

              onTap: pickStartDate,
            ),

            ListTile(
              title: Text(
                endDate == null
                    ? 'Select End Date'
                    : endDate.toString()
                        .split(' ')[0],
              ),

              trailing:
                  const Icon(Icons.calendar_month),

              onTap: pickEndDate,
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  activitiesController,

              maxLines: 4,

              decoration:
                  const InputDecoration(
                labelText: 'Activities',
                hintText:
                    'Beach, hiking, city walks...',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: saveTrip,

                child: const Text(
                  'Save Trip',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}