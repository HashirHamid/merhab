import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/screens/plan_trip_screens/add_trip_screen.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/planned_trip_tile_widget.dart';
import 'package:merhab/theme/themes.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripPlanForm(),
            ),
          );
        },
        backgroundColor: AppTheme.primaryLavenderColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Trip Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (tripController.isLoadingTrips.value) {
            return Center(child: CircularProgressIndicator());
          }
          else if(tripController.tripList.isEmpty){
            return Center(child: Text("No Trips Created Yet."),);
          }

          return SingleChildScrollView(
            child: Column(
              children: tripController.tripList.map((trip) {
                return PlannedTripTileWidget(
                  trip: trip,
                  activities: tripController.activitiesList,
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
