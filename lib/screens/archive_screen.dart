import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trips = [
      {'title': 'Trip to Paris', 'date': '2023-01-15'},
      {'title': 'Trip to New York', 'date': '2023-02-20'},
      {'title': 'Trip to Tokyo', 'date': '2023-03-10'},
      {'title': 'Trip to Sydney', 'date': '2023-04-05'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Archived Trips'),
      ),
      body: ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Card(
            elevation: 4,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(trip['title']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip['date']!),
                  Text('Duration: 5 days'), // Example duration
                  Text(
                      'From: Pickup Location to Destination'), // Example pickup to destination
                ],
              ),
              leading: const Icon(Icons.flight_takeoff),
            ),
          );
        },
      ),
    );
  }
}
