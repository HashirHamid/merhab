import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  void _showEmergencyInfo(
      BuildContext context, String title, String info1, String info2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: AppTheme.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(info1),
              const SizedBox(height: 8),
              Text(info2),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContainer(
    BuildContext context,
    String title,
    IconData icon,
    String info1,
    String info2,
  ) {
    return GestureDetector(
      onTap: () => _showEmergencyInfo(context, title, info1, info2),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          'Emergency',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainer(
                context,
                'General Emergency Numbers',
                Icons.phone_in_talk,
                'Police: 999',
                'Ambulance: 998',
              ),
              _buildContainer(
                context,
                'Accidents and Security',
                Icons.security,
                'Traffic Police: 993',
                'Civil Defense: 997',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Second Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainer(
                context,
                'Public Services',
                Icons.public,
                'Municipality: 800-1234',
                'Electricity: 800-5678',
              ),
              _buildContainer(
                context,
                'Inquiries and Complaints',
                Icons.question_answer,
                'General Info: 800-9012',
                'Complaints: 800-3456',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Third Row (centered single container)
          Center(
            child: _buildContainer(
              context,
              'Embassy',
              Icons.account_balance,
              'US Embassy: +123-456-7890',
              'UK Embassy: +123-456-7891',
            ),
          ),
        ],
      ),
    );
  }
}
