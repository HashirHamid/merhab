import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/screens/plan_trip_screens/activity_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/validator_mixin.dart';

class TripPlanForm extends StatefulWidget {
  @override
  _TripPlanFormState createState() => _TripPlanFormState();
}

class _TripPlanFormState extends State<TripPlanForm> with ValidationMixin {
  final _destinationController = TextEditingController();
  final _tripNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _travelerNameController = TextEditingController();
  final _travelerContactController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  void clearData() {
    _destinationController.clear();
    _tripNameController.clear();
    _descriptionController.clear();
    _travelerNameController.clear();
    _travelerContactController.clear();

    _startDate = null;
    _endDate = null;
  }

  final tripPlanController = Get.find<TripPlanController>();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate ? (_startDate ?? initialDate) : (_endDate ?? initialDate),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void assignValues() {
    tripPlanController.trip.value.tripName = _tripNameController.text;
    tripPlanController.trip.value.tripDescription = _descriptionController.text;
    tripPlanController.trip.value.tripDestination = _destinationController.text;
    tripPlanController.trip.value.startDate = _startDate.toString();
    tripPlanController.trip.value.endDate = _endDate.toString();
    tripPlanController.trip.value.travelerName = _travelerNameController.text;
    tripPlanController.trip.value.travelerContact =
        _travelerContactController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Trip Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  hintText: 'Enter the destination',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                        text: _startDate == null
                            ? ''
                            : _startDate!.toLocal().toString().split(' ')[0]),
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'Select the start date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                        text: _endDate == null
                            ? ''
                            : _endDate!.toLocal().toString().split(' ')[0]),
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      hintText: 'Select the end date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _tripNameController,
                decoration: InputDecoration(
                  labelText: 'Trip Name',
                  hintText: 'Enter the trip name',
                  prefixIcon: Icon(Icons.trip_origin),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter a description for the trip',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4),
              SizedBox(height: 16),
              TextField(
                controller: _travelerNameController,
                decoration: InputDecoration(
                  labelText: 'Traveler Name',
                  hintText: 'Enter the traveler name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _travelerContactController,
                decoration: InputDecoration(
                  labelText: 'Traveler Contact No.',
                  hintText: 'Enter the Traveler Contact No.',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Obx(() {
                return Wrap(
                  children: tripPlanController.activities
                      .map((e) => Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreenColor,
                              borderRadius: BorderRadius.circular(40),
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 2,
                              //     spreadRadius: 1,
                              //     color: const Color.fromARGB(61, 139, 139, 139)
                              //   )
                              // ]
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage: AssetImage(
                                      'assets/flutter_logo.png'), 
                                ),
                                SizedBox(width: 8.0),
                                Text(e.eventName ?? ""),
                                IconButton(
                                    onPressed: () {
                                      tripPlanController
                                          .removeActivity(e.eventName);
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: AppTheme.backgroundColor,
                                    ))
                              ],
                            ),
                          ))
                      .toList(),
                );
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (validateForm()) {
                        assignValues();
                        await tripPlanController.createTrip();
                        clearData();
                        tripPlanController.clearActivity();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Save Trip Plan"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => ActivityListScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Add Activities"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    if (_destinationController.text.trim().isEmpty) {
      showError("Destination is required.");
      return false;
    }
    if (_startDate == null) {
      showError("Start date is required.");
      return false;
    }
    if (_endDate == null) {
      showError("End date is required.");
      return false;
    }
    if (_tripNameController.text.trim().isEmpty) {
      showError("Trip name is required.");
      return false;
    }
    if (_travelerNameController.text.trim().isEmpty) {
      showError("Traveler name is required.");
      return false;
    }
    if (_travelerContactController.text.trim().isEmpty) {
      showError("Traveler contact number is required.");
      return false;
    }
    return true;
  }
}
