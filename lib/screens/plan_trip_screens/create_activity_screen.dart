import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({this.activityName});

  final String? activityName;

  @override
  _ActivityFormScreenState createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  final _activityTypeController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _venueController = TextEditingController();
  final _addressController = TextEditingController();
  final _timezoneController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void clearActivityData() {
    _activityTypeController.clear();
    _eventNameController.clear();
    _venueController.clear();
    _addressController.clear();
    _timezoneController.clear();

    _startDate = null;
    _endDate = null;

    _startTime = null;
    _endTime = null;
  }

  // bool _confirmation = false;

  @override
  void initState() {
    super.initState();
    _activityTypeController.text = widget.activityName ?? "";
  }

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

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  final tripPlanController = Get.find<TripPlanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Activity"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.save),
        //     onPressed: _saveActivity, // Save action when the button is pressed
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                enabled: false,
                controller: _activityTypeController,
                decoration: InputDecoration(
                  labelText: 'Activity Type',
                  hintText: 'Enter the activity type',
                  prefixIcon: Icon(Icons.event),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _eventNameController,
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  hintText: 'Enter the event name',
                  prefixIcon: Icon(Icons.event_note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _venueController,
                decoration: InputDecoration(
                  labelText: 'Venue',
                  hintText: 'Enter the venue',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter the address',
                  prefixIcon: Icon(Icons.home),
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
              GestureDetector(
                onTap: () => _selectTime(context, true),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                        text: _startTime == null
                            ? ''
                            : _startTime!.format(context)),
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      hintText: 'Select the start time',
                      prefixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTime(context, false),
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(
                        text:
                            _endTime == null ? '' : _endTime!.format(context)),
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      hintText: 'Select the end time',
                      prefixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _timezoneController,
                decoration: InputDecoration(
                  labelText: 'Time Zone',
                  hintText: 'Enter the time zone',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Row(
              //   children: [
              //     Checkbox(
              //       value: _confirmation,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           _confirmation = value ?? false;
              //         });
              //       },
              //     ),
              //     Text("Confirm details"),
              //   ],
              // ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  tripPlanController.addActivity(ActivityModel(
                    activityType: _activityTypeController.text,
                    eventName: _eventNameController.text,
                    venue: _venueController.text,
                    address: _addressController.text,
                    startDate: _startDate.toString(),
                    endDate: _endDate.toString(),
                    startTime: _startTime.toString(),
                    endTime: _endTime.toString(),
                    timezone: _timezoneController.text,
                  ));
                  clearActivityData();
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Save Activity"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
