import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:merhab/screens/plan_trip_screens/create_activity_screen.dart';
import 'package:merhab/utils/app_images.dart';

class ActivityListScreen extends StatelessWidget {

  ActivityListScreen({this.tripId});
String? tripId;

  final Map<String, String> activities = {
    'Sightseeing Tour': AppImages.sightSeeing,
    'Nature Hike/Adventure Trekking': AppImages.hikingImage,
    'Cultural Experiences': AppImages.cultureImage,
    'Beach Day/Water Sports': AppImages.beachImage,
    'Food Tour': AppImages.streetFood,
    'Wildlife Safari': AppImages.wildLifeImage,
    'Sunset/Sunrise Viewing': AppImages.sunsetImage,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Activity'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          String placeName = activities.keys.elementAt(index);
          String imagePath = activities[placeName]!;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Image.asset(imagePath),
              title: Text(
                placeName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Tap to add activity details'),
              onTap:(){
                Get.to(()=> ActivityFormScreen(activityName: placeName,tripId: tripId,));
              },
            ),
          );
        },
      ),
    );
  }
}
