import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/screens/add_place_screen.dart';
import 'package:merhab/screens/add_souvenir_store.dart';
import 'package:merhab/screens/emergency_screen.dart';
import 'package:merhab/screens/setup_profile_screen.dart';
import 'package:merhab/screens/transportation_screen.dart';
import 'package:merhab/screens/travel_info_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Personal Info'),
              onTap: () {
                Get.to(() => SetupProfileScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.flight),
              title: const Text('Travel Info'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TravelInfoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Emergency'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Transportation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransportationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Add Store'),
              onTap: () {
                Get.to(() => const AddSouvenirStore());
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Add Place'),
              onTap: () {
                Get.to(() => AddPlaceScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_esports),
              title: const Text('Activities'),
              onTap: () {
                // TODO: Navigate to activities
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Market'),
              onTap: () {
                // TODO: Navigate to market
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive'),
              onTap: () {
                // TODO: Navigate to archive
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Contact Us'),
              onTap: () {
                // TODO: Navigate to contact us
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Get.find<AuthController>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
