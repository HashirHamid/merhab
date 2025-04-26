import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/theme/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationScreen extends StatelessWidget {
  const TransportationScreen({super.key});

  void _launchApp(String url, String appStoreUrl) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // If the app is not installed, open the app store
      if (await canLaunchUrl(Uri.parse(appStoreUrl))) {
        await launchUrl(Uri.parse(appStoreUrl));
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkGreenColor,
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
        elevation: 0,
        title: Text(
          "Transportation",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36),
              child: Text(
                "Car Rentals",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkGreenColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer(
                    'Key Car Rental',
                    'assets/key.png',
                    'keycar://',
                    'https://play.google.com/store/apps/details?id=comcom.key'),
                _buildTransportContainer(
                    'Theeb',
                    'assets/theeb.png',
                    'theeb://',
                    'https://play.google.com/store/apps/details?id=com.theeb'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer('Sixt', 'assets/sixt.png', 'sixt://',
                    'https://play.google.com/store/apps/details?id=com.sixt.reservation'),
                _buildTransportContainer('Yelo', 'assets/yelo.png', 'yelo://',
                    'https://play.google.com/store/apps/details?id=com.wefaq.carsapp'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
