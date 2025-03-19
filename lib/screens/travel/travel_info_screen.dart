import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';

class TravelInfoScreen extends StatefulWidget {
  const TravelInfoScreen({Key? key}) : super(key: key);

  @override
  State<TravelInfoScreen> createState() => _TravelInfoScreenState();
}

class _TravelInfoScreenState extends State<TravelInfoScreen> {
  final _departureLocationController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _arrivalLocationController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _accommodationController = TextEditingController();
  final _hotelController = TextEditingController();
  final _visaRequirementsController = TextEditingController();

  @override
  void dispose() {
    _departureLocationController.dispose();
    _departureTimeController.dispose();
    _departureDateController.dispose();
    _arrivalLocationController.dispose();
    _arrivalTimeController.dispose();
    _arrivalDateController.dispose();
    _flightNumberController.dispose();
    _accommodationController.dispose();
    _hotelController.dispose();
    _visaRequirementsController.dispose();
    super.dispose();
  }

  Widget _buildTimeAndDateRow(
    String locationLabel,
    TextEditingController locationController,
    TextEditingController timeController,
    TextEditingController dateController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locationLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Location
            Expanded(
              flex: 2,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Location',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Time
            Expanded(
              child: TextField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: 'Time',
                  prefixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    timeController.text = time.format(context);
                  }
                },
                readOnly: true,
              ),
            ),
            const SizedBox(width: 8),
            // Date
            Expanded(
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    dateController.text =
                        "${date.day}/${date.month}/${date.year}";
                  }
                },
                readOnly: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text('Travel Information'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Departure Section
            _buildTimeAndDateRow(
              'Departure Details',
              _departureLocationController,
              _departureTimeController,
              _departureDateController,
            ),
            const SizedBox(height: 24),

            // Arrival Section
            _buildTimeAndDateRow(
              'Arrival Details',
              _arrivalLocationController,
              _arrivalTimeController,
              _arrivalDateController,
            ),
            const SizedBox(height: 24),

            // Flight Number
            TextField(
              controller: _flightNumberController,
              decoration: InputDecoration(
                labelText: 'Flight Number',
                hintText: 'Enter flight number',
                prefixIcon: const Icon(Icons.flight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Accommodation
            TextField(
              controller: _accommodationController,
              decoration: InputDecoration(
                labelText: 'Accommodation Type',
                hintText: 'Enter accommodation type',
                prefixIcon: const Icon(Icons.home_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Hotel/Airbnb
            TextField(
              controller: _hotelController,
              decoration: InputDecoration(
                labelText: 'Hotel/Airbnb Details',
                hintText: 'Enter hotel or Airbnb details',
                prefixIcon: const Icon(Icons.hotel),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Visa Requirements
            TextField(
              controller: _visaRequirementsController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Visa and Entry Requirements',
                hintText: 'Enter visa and entry requirements',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save functionality
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Travel Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
