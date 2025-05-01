import 'package:flutter/material.dart';

class TimeZoneDropdown extends StatefulWidget {
  TimeZoneDropdown({this.onChanged});

  @override
  _TimeZoneDropdownState createState() => _TimeZoneDropdownState();

  void Function(String?)? onChanged;
}

class _TimeZoneDropdownState extends State<TimeZoneDropdown> {
  // List of time zones (can be extended)
  final List<String> timeZones = [
    'GMT',
    'UTC',
    'PST (Pacific Standard Time)',
    'EST (Eastern Standard Time)',
    'CET (Central European Time)',
    'IST (Indian Standard Time)',
    'JST (Japan Standard Time)',
    'AEST (Australian Eastern Standard Time)',
  ];

  String? selectedTimeZone; // The currently selected time zone

  @override
  void initState() {
    super.initState();
    selectedTimeZone = timeZones[0]; // Default to the first time zone
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Time Zone:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          DropdownButton<String>(
            value: selectedTimeZone,
            onChanged: widget.onChanged,
            items: timeZones.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
