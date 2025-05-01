import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/screens/plan_trip_screens/add_trip_screen.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/trip_detail.dart';
import 'package:merhab/theme/themes.dart';

class TriplistScreen extends StatefulWidget {
  TriplistScreen({super.key});

  @override
  State<TriplistScreen> createState() => _TriplistScreenState();
}

class _TriplistScreenState extends State<TriplistScreen> {
  final tripController = Get.find<TripPlanController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await tripController.getTableData("Trip");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripPlanForm()),
            );
            await tripController.getTableData("Trip");
          },
          backgroundColor: AppTheme.primaryLavenderColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        body: Obx(() => tripController.isLoadingTrips.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : tripController.tripList.isEmpty
                ? Center(
                    child: Text("No Trips Found."),
                  )
                : ListView.builder(
                    itemCount: tripController.tripList.length,
                    itemBuilder: (context, index) {
                      final trip = tripController.tripList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TripDetailsScreen(
                                trip: trip,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                          31, 126, 126, 126),
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 150,
                                    width: 180,
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      "https://img.freepik.com/free-photo/backpacker-standing-sunrise-viewpoint-ja-bo-village-mae-hong-son-province-thailand_335224-1356.jpg?semt=ais_hybrid&w=740",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trip.tripName ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        trip.tripDescription ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )));
  }
}
