import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/widgets/item_container_widget.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  void _showEmergencyInfo(
      BuildContext context, String title, String info1, String info2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: AppTheme.primaryLavenderColor),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Emergency",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemContainer(
                title: 'General Emergency ',
                imagePath: "assets/general_emergency.png",
                onTap: () =>
                    _showEmergencyInfo(context, "title", "info1", "info2"),
              ),
              ItemContainer(
                title: 'Accidents and Security',
                imagePath: "assets/accident.png",
                onTap: () =>
                    _showEmergencyInfo(context, "title", "info1", "info2"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Second Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemContainer(
                title: 'Public Services',
                imagePath: "assets/public-service.png",
                onTap: () =>
                    _showEmergencyInfo(context, "title", "info1", "info2"),
              ),
              ItemContainer(
                title: 'Inquiries and Complaints',
                imagePath: "assets/complaint.png",
                onTap: () =>
                    _showEmergencyInfo(context, "title", "info1", "info2"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
