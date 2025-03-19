import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/screens/home/home_layout.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({Key? key}) : super(key: key);

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final _nationalityController = TextEditingController();
  final _ageController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _relativeController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedBloodType = 'A+';

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  @override
  void dispose() {
    _nationalityController.dispose();
    _ageController.dispose();
    _emergencyContactController.dispose();
    _relativeController.dispose();
    super.dispose();
  }

  Widget _buildRadioGroup({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) => onChanged(value!),
                  activeColor: AppTheme.primaryColor,
                ),
                Text(
                  option,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Setup Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please fill in your details',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.greyTextColor,
                    ),
              ),
              const SizedBox(height: 32),

              // Nationality Field
              TextField(
                controller: _nationalityController,
                decoration: const InputDecoration(
                  labelText: 'Nationality',
                  hintText: 'Enter your nationality',
                  prefixIcon: Icon(Icons.public),
                ),
              ),
              const SizedBox(height: 24),

              // Gender Radio Buttons
              _buildRadioGroup(
                title: 'Gender',
                options: ['Male', 'Female', 'Other'],
                selectedValue: _selectedGender,
                onChanged: (value) => setState(() => _selectedGender = value),
              ),
              const SizedBox(height: 24),

              // Age Field
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 24),

              // Blood Type Radio Buttons
              _buildRadioGroup(
                title: 'Blood Type',
                options: _bloodTypes,
                selectedValue: _selectedBloodType,
                onChanged: (value) =>
                    setState(() => _selectedBloodType = value),
              ),
              const SizedBox(height: 24),

              // Emergency Contact Field
              TextField(
                controller: _emergencyContactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact',
                  hintText: 'Enter emergency contact number',
                  prefixIcon: Icon(Icons.emergency),
                ),
              ),
              const SizedBox(height: 24),

              // Relative Field
              TextField(
                controller: _relativeController,
                decoration: const InputDecoration(
                  labelText: 'Relative',
                  hintText: 'Enter relative name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Basic validation
                  // if (_nationalityController.text.isNotEmpty &&
                  //     _ageController.text.isNotEmpty &&
                  //     _emergencyContactController.text.isNotEmpty &&
                  //     _relativeController.text.isNotEmpty) {
                  // Navigate to home layout
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeLayout(),
                    ),
                    (route) => false, // Remove all previous routes
                  );
                  // }
                },
                child: Text(
                  'Submit',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
