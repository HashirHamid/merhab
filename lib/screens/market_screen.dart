import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/screens/web_view_screen.dart';
import 'package:merhab/theme/themes.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  Widget _buildTransportContainer(
    String title,
    String imagePath,
    String url,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewScreen(
              title: title,
              url: url,
            ));
      },
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
              textAlign: TextAlign.center,
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
          "Market",
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
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36),
            //   child: Text(
            //     "Car Rentals",
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w500,
            //         color: AppTheme.darkGreenColor),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer(
                    'Saudi Business Center',
                    'assets/saudi-business.jpeg',
                    'eauthenticate.saudibusiness.gov.sa/inquiry'),
                _buildTransportContainer(
                    'Maroof', 'assets/maroof.jpeg', 'maroof.sa/'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransportContainer(
                    'Souvenirs', 'assets/sovenirs.png', 'souvenirs.sa/en'),
                // _buildTransportContainer('Yelo', 'assets/yelo.png',
                //     'https://play.google.com/store/apps/details?id=com.wefaq.carsapp'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
