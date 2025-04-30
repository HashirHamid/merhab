import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/activity_timezone.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({this.activityName, this.tripId});
  final String? activityName;
  final String? tripId;

  @override
  _ActivityFormScreenState createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  final _activityTypeController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _venueController = TextEditingController();
  final _addressController = TextEditingController();
  String? _timezoneController = "";

  DateTime? _startDate;
  DateTime? _endDate;

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final tripPlanController = Get.find<TripPlanController>();

  @override
  void initState() {
    super.initState();
    _activityTypeController.text = widget.activityName ?? "";
  }

  void clearActivityData() {
    _activityTypeController.clear();
    _eventNameController.clear();
    _venueController.clear();
    _addressController.clear();
    _timezoneController = "";
    _startDate = null;
    _endDate = null;
    _startTime = null;
    _endTime = null;
    setState(() {});
  }

  void _showSnackbar(String message, {bool isError = false}) {
    final color = isError ? Colors.red : Colors.green;
    final icon = isError ? Icons.error : Icons.check_circle;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
                child: Text(message, style: TextStyle(color: Colors.white))),
          ],
        ),
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  bool _validateInputs() {
    if (_activityTypeController.text.isEmpty) {
      _showSnackbar("Activity Type is required", isError: true);
      return false;
    }
    if (_eventNameController.text.isEmpty) {
      _showSnackbar("Event Name is required", isError: true);
      return false;
    }
    if (_venueController.text.isEmpty) {
      _showSnackbar("Venue is required", isError: true);
      return false;
    }
    if (_addressController.text.isEmpty) {
      _showSnackbar("Address is required", isError: true);
      return false;
    }
    if (_startDate == null) {
      _showSnackbar("Start Date is required", isError: true);
      return false;
    }
    if (_endDate == null) {
      _showSnackbar("End Date is required", isError: true);
      return false;
    }
    if (_startTime == null) {
      _showSnackbar("Start Time is required", isError: true);
      return false;
    }
    if (_endTime == null) {
      _showSnackbar("End Time is required", isError: true);
      return false;
    }
    if (_timezoneController?.isEmpty ?? true) {
      _showSnackbar("Time Zone is required", isError: true);
      return false;
    }
    return true;
  }

  void _saveActivity() {
    if (!_validateInputs()) return;

    if (widget.tripId == null) {
      tripPlanController.addActivity(ActivityModel(
        activityType: _activityTypeController.text,
        eventName: _eventNameController.text,
        venue: _venueController.text,
        address: _addressController.text,
        startDate: _startDate.toString(),
        endDate: _endDate.toString(),
        startTime: _startTime.toString(),
        endTime: _endTime.toString(),
        timezone: _timezoneController,
      ));
    } else {
      tripPlanController.createActivity(ActivityModel(
        tripId: widget.tripId,
        activityType: _activityTypeController.text,
        eventName: _eventNameController.text,
        venue: _venueController.text,
        address: _addressController.text,
        startDate: _startDate.toString(),
        endDate: _endDate.toString(),
        startTime: _startTime.toString(),
        endTime: _endTime.toString(),
        timezone: _timezoneController,
      ));
    }

    clearActivityData();
    _showSnackbar("Activity Saved Successfully");

    Future.delayed(Duration(milliseconds: 500), () {
      Get.back();
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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

  @override
  Widget build(BuildContext context) {
    print("Here is the data-------->${widget.tripId}");
    return Scaffold(
      appBar: AppBar(title: Text("Create Activity")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(
                  _activityTypeController, "Activity Type", Icons.event,
                  enabled: false),
              SizedBox(height: 16),
              _buildTextField(
                  _eventNameController, "Event Name", Icons.event_note),
              SizedBox(height: 16),
              _buildTextField(_venueController, "Venue", Icons.location_on),
              SizedBox(height: 16),
              _buildTextField(_addressController, "Address", Icons.home),
              SizedBox(height: 16),
              _buildDatePicker(
                  "Start Date", _startDate, () => _selectDate(context, true)),
              SizedBox(height: 16),
              _buildDatePicker(
                  "End Date", _endDate, () => _selectDate(context, false)),
              SizedBox(height: 16),
              _buildTimePicker(
                  "Start Time", _startTime, () => _selectTime(context, true)),
              SizedBox(height: 16),
              _buildTimePicker(
                  "End Time", _endTime, () => _selectTime(context, false)),
              SizedBox(height: 16),
              SizedBox(
                  width: double.infinity,
                  child: TimeZoneDropdown(
                    onChanged: (value) {
                      setState(() {
                        _timezoneController = value;
                      });
                    },
                  )),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Save Activity", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
              text:
                  date == null ? "" : date.toLocal().toString().split(' ')[0]),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
              text: time == null ? "" : time.format(context)),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(Icons.access_time),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
