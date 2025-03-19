import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/screens/chat/chat_bot_screen.dart';
import 'package:merhab/screens/archive_screen.dart';
import 'package:merhab/screens/info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildContainer(String title, IconData icon) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: AppTheme.primaryColor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Grid of 4 containers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainer('Emergency', Icons.emergency),
              _buildContainer('Transportation', Icons.directions_car),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainer('Activities', Icons.sports_esports),
              _buildContainer('Market', Icons.shopping_cart),
            ],
          ),
          const SizedBox(height: 32),
          // Text Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArchiveScreen()),
                  );
                },
                child: const Text(
                  'Archive',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoScreen()),
                  );
                },
                child: const Text(
                  'Info',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
