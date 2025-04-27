import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/planned_trip_tile_widget.dart';

class TripDetailsScreen extends StatefulWidget {
  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final tripController = Get.find<TripPlanController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await tripController.getTableData("Trip");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trip Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (tripController.isLoadingTrips.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: tripController.tripList.map((trip) {
                return PlannedTripTileWidget(
                  trip: trip,
                  activities: tripController.activities,
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
