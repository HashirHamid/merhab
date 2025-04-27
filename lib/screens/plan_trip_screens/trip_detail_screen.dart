import 'package:flutter/material.dart';

class TripDetailsScreen extends StatefulWidget {
  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int _currentStep = 0;
  List<Step> _steps = [
    Step(
      title: Text('Event 1'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date: 2025-05-01", style: TextStyle(fontSize: 16)),
          Text("Time: 10:00 AM", style: TextStyle(fontSize: 16)),
          Text("Description: Visit to the museum.",
              style: TextStyle(fontSize: 16)),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Event 2'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date: 2025-05-02", style: TextStyle(fontSize: 16)),
          Text("Time: 2:00 PM", style: TextStyle(fontSize: 16)),
          Text("Description: Dinner at the famous restaurant.",
              style: TextStyle(fontSize: 16)),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text('Event 3'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date: 2025-05-03", style: TextStyle(fontSize: 16)),
          Text("Time: 9:00 AM", style: TextStyle(fontSize: 16)),
          Text("Description: Hiking trip in the mountains.",
              style: TextStyle(fontSize: 16)),
        ],
      ),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Trip Name, Start & End Date, and Image
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip to Paris', // Trip Name
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'Start: 2025-05-01', // Start Date
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'End: 2025-05-05', // End Date
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://assets.bucketlistly.blog/sites/5adf778b6eabcc00190b75b1/content_entry5b155bed5711a8176e9f9783/5c4fbe2246025317508def41/files/nepal-everest-base-camp-everest-travel-photo-20190128094442660-main-image.jpg', // Add your image here
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Stepper Widget for Events
              Stepper(
                currentStep: _currentStep,
                onStepTapped: (step) {
                  setState(() {
                    _currentStep = step;
                  });
                },
                onStepContinue: () {
                  if (_currentStep < _steps.length - 1) {
                    setState(() {
                      _currentStep++;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep--;
                    });
                  }
                },
                steps: _steps,
              ),
              SizedBox(height: 24),

              // Destination Description
              Text(
                'Destination Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Paris is known for its art, fashion, and culture. The Eiffel Tower, Louvre Museum, and Notre-Dame are must-visit attractions in the city.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),

              // Traveller Details
              Text(
                'Traveller Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
