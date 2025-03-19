import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationScreen extends StatelessWidget {
  const TransportationScreen({Key? key}) : super(key: key);

  void _launchApp(String url, String appStoreUrl) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // If the app is not installed, open the app store
      if (await canLaunch(appStoreUrl)) {
        await launch(appStoreUrl);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget _buildTransportContainer(
      String title, String imagePath, String url, String appStoreUrl) {
    return GestureDetector(
      onTap: () => _launchApp(url, appStoreUrl),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              title,
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
        title: const Text(
          'Transportation',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer('Uber', 'assets/uber.png', 'uber://',
                    'https://play.google.com/store/apps/details?id=com.ubercab'),
                _buildTransportContainer(
                    'Shift',
                    'assets/shift.png',
                    'shift://',
                    'https://play.google.com/store/apps/details?id=com.innovitics.app.shift'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer(
                    'Careem',
                    'assets/careem.jpg',
                    'careem://',
                    'https://play.google.com/store/apps/details?id=com.careem.acma'),
                _buildTransportContainer('Darb', 'assets/darb.png', 'darb://',
                    'https://play.google.com/store/apps/details?id=com.rcrc.riyadhjourneyplanner'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
