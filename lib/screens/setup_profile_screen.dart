import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/screens/home_layout.dart';

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
  void initState() {
    final user = Get.find<AuthController>().userData;
    _nationalityController.text = user.nationality ?? "";
    _ageController.text = user.age ?? "";
    _emergencyContactController.text = user.emergencyContact ?? "";
    _relativeController.text = user.relative ?? "";
    _selectedGender = user.gender ?? "Male";
    _selectedBloodType = user.bloodType ?? "A+";
    super.initState();
  }

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
                  activeColor: AppTheme.primaryGreenColor,
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
        leading: SizedBox.shrink(),
        actions: [
          TextButton(
              onPressed: () {
                Get.to(() => HomeLayout());
              },
              child: Text(
                "Skip",
                style: TextStyle(color: AppTheme.primaryLavenderColor),
              )),
        ],
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
                  color: AppTheme.primaryGreenColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please fill in your details',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primaryLavenderColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),

              // Nationality Field
              TextField(
                controller: _nationalityController,
                decoration: const InputDecoration(
                  labelText: 'Nationality',
                  hintText: 'Enter your nationality',
                  prefixIcon: Icon(
                    Icons.public,
                    color: AppTheme.primaryGreenColor,
                  ),
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
                  prefixIcon: Icon(Icons.calendar_today,
                      color: AppTheme.primaryGreenColor),
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
                  prefixIcon:
                      Icon(Icons.emergency, color: AppTheme.primaryGreenColor),
                ),
              ),
              const SizedBox(height: 24),

              // Relative Field
              TextField(
                controller: _relativeController,
                decoration: const InputDecoration(
                  labelText: 'Relative',
                  hintText: 'Enter relative name',
                  prefixIcon: Icon(Icons.person_outline,
                      color: AppTheme.primaryGreenColor),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button

              Obx(
                () => Get.find<AuthController>().isLoadingProfile.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (_nationalityController.text.isNotEmpty &&
                              _ageController.text.isNotEmpty &&
                              _emergencyContactController.text.isNotEmpty &&
                              _relativeController.text.isNotEmpty) {
                            Get.find<AuthController>().setupProfile(
                                _nationalityController.text,
                                _selectedGender,
                                _ageController.text,
                                _selectedBloodType,
                                _emergencyContactController.text,
                                _relativeController.text);
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please fill in all fields',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2),
                            );
                          }
                        },
                        child: Text(
                          'Submit',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
