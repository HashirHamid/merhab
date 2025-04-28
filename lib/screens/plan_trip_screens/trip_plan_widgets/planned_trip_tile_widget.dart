import 'package:flutter/material.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';
import 'package:merhab/models/trip_plan_model/trip_model.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/helper_function.dart';

class PlannedTripTileWidget extends StatefulWidget {
  final TripModel? trip;
  final List<ActivityModel>? activities;

  PlannedTripTileWidget({this.trip, this.activities, super.key});

  @override
  _PlannedTripTileWidgetState createState() => _PlannedTripTileWidgetState();
}

class _PlannedTripTileWidgetState extends State<PlannedTripTileWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final List<ActivityModel> tripActivities = widget.activities != null
        ? widget.activities!
            .where((activity) => activity.tripId == widget.trip?.id)
            .toList()
        : [];

    if (_currentStep >= tripActivities.length) {
      _currentStep = 0;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(160, 224, 224, 224),
                spreadRadius: 1,
                blurRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.trip?.tripName ?? "",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Start: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryLavenderColor,
                              ),
                            ),
                            TextSpan(
                              text: formatDate(widget.trip?.startDate ?? ""),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'End: ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryLavenderColor),
                            ),
                            TextSpan(
                              text: formatDate(widget.trip?.endDate ?? ""),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: Image.network(
              //     'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?fm=jpg',
              //     width: 170,
              //     height: 170,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 24),
          if (tripActivities.isNotEmpty)
            Stepper(
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () {
                if (_currentStep < tripActivities.length - 1) {
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
              steps: tripActivities.asMap().entries.map((entry) {
                final int index = entry.key; // 👈 index available
                final activity = entry.value; // 👈 actual activity object

                return Step(
                  title: Text(activity.eventName ?? ""),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ${formatDate(activity.startDate ?? "")}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Time: ${activity.startTime ?? ''}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Venue: ${activity.venue ?? ''}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  isActive: _currentStep ==
                      index, // ✅ Now you have the correct index!
                );
              }).toList(),
            ),
          SizedBox(height: 24),
          Text(
            'Description:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            widget.trip?.tripDescription ?? "No description available.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          Text(
            'Traveller Details:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            widget.trip?.tripName ?? "Unknown Traveller",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
