import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trips = [
      {'title': 'Trip to London', 'date': '2023-05-15'},
      {'title': 'Trip to Berlin', 'date': '2023-06-20'},
      {'title': 'Trip to Rome', 'date': '2023-07-10'},
      {'title': 'Trip to Madrid', 'date': '2023-08-05'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text('My Trips'),
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
                  Text('Duration: 7 days'), // Example duration
                  Text(
                      'From: Pickup Location to Destination'), // Example pickup to destination
                ],
              ),
              leading: const Icon(Icons.flight_land),
            ),
          );
        },
      ),
    );
  }
}
