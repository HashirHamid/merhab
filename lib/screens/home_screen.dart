import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/screens/about_saudi_screen.dart';
import 'package:merhab/screens/activities_screen.dart';
import 'package:merhab/screens/emergency_screen.dart';
import 'package:merhab/screens/market_screen.dart';
import 'package:merhab/screens/plan_trip_screens/create_activity_screen.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/trip_detail.dart';
import 'package:merhab/screens/transportation_screen.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/app_images.dart';
import 'package:merhab/utils/banner.dart';
import 'package:merhab/widgets/item_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grid of 4 containers
          TravelBanner(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemContainer(
                  title: 'Emergency',
                  imagePath: 'assets/emergency.png',
                  onTap: () {
                    Get.to(() => EmergencyScreen());
                  }),
              ItemContainer(
                  title: 'Transportation',
                  imagePath: 'assets/transportation.png',
                  onTap: () {
                    Get.to(() => TransportationScreen());
                  }),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemContainer(
                  title: 'Activities',
                  imagePath: 'assets/activities.png',
                  onTap: () {
                    Get.to(() => ActivitiesScreen());
                  }),
              ItemContainer(
                  title: 'Market',
                  imagePath: 'assets/market.png',
                  onTap: () {
                    Get.to(() => MarketScreen());
                  }),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Get.to(() => TripDetailsScreen());
              },
              child: Container(
              width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(31, 148, 148, 148)),
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100, child: Image.asset(AppImages.travelImage)),
                       
                    Text("Show Trips",style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text("Know Before You Go",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGreenColor)),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(() => AboutSaudiPage());
                },
                child: Column(
                  children: [
                    Image.asset('assets/careem.jpg',
                        width: 120, height: 120, fit: BoxFit.cover),
                    const SizedBox(height: 8),
                    Text(
                      'About Saudi',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkGreenColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
