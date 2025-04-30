import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/screens/plan_trip_screens/trip_plan_widgets/trip_detail.dart';
import 'package:merhab/screens/plan_trip_screens/triplist_screen.dart';
import 'package:merhab/theme/themes.dart';

class TravelBanner extends StatefulWidget {
  @override
  _TravelBannerState createState() => _TravelBannerState();
}

class _TravelBannerState extends State<TravelBanner>
    with SingleTickerProviderStateMixin {
  bool _isIconTapped = false; // To track icon tap for animation
  bool _isButtonHovered = false; // To track button hover/tap for animation

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the layout should be horizontal (desktop) or vertical (mobile)

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryGreenColor,
                AppTheme.primaryGreenColor.withOpacity(0.8),
                AppTheme.secondaryLavenderColor.withOpacity(0.8),
                AppTheme.secondaryLavenderColor
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _buildTextAndButtonSection()),
                  _buildIconSection(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconSection() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isIconTapped = !_isIconTapped; // Toggle animation on tap
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Subtle animated icon (airplane moves up slightly)
          AnimatedContainer(
            duration:
                Duration(milliseconds: 200), // Shorter duration for subtlety
            transform: Matrix4.translationValues(
                0, _isIconTapped ? -10 : 0, 0), // Reduced movement
            child: Image.asset(
              'assets/travel-bag.png', // Replace with your icon path
              width: 100, // Smaller icon size
              height: 100,
            ),
          ),
          // Dotted flight path animation (made smaller and more subtle)
          CustomPaint(
            painter: DottedPathPainter(),
            size: Size(120, 120), // Reduced size
          ),
        ],
      ),
    );
  }

  Widget _buildTextAndButtonSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0), // Add padding to the left
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align text and button to the left
        children: [
          // Title with highlighted "Trip" (smaller font size for subtlety)
          RichText(
            maxLines: 2,
            text: TextSpan(
              style: TextStyle(
                fontSize: 20, // Reduced font size
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black12, // Softer shadow
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              children: [
                TextSpan(
                  text: 'Plan a ',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Trip',
                  style:
                      TextStyle(color: AppTheme.primaryLavenderColor), // Orange
                ),
                TextSpan(
                  text: ' with Us Today!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 30), // Reduced spacing
          // Start Planning button with subtle tap animation
          GestureDetector(
            onTap: (){
              Get.to(() => TriplistScreen());
            },
            onTapDown: (_) {
              setState(() {
                _isButtonHovered = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isButtonHovered = false;
              });
              // Navigate to the next page (replace with your navigation logic)
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
            },
            child: AnimatedContainer(
              duration:
                  Duration(milliseconds: 150), // Shorter duration for subtlety
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8), // Smaller button
              decoration: BoxDecoration(
                color: AppTheme.primaryLavenderColor, // Teal
                borderRadius:
                    BorderRadius.circular(8), // Slightly smaller radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, // Softer shadow
                    blurRadius:
                        _isButtonHovered ? 4 : 2, // Reduced shadow effect
                    offset: Offset(0, _isButtonHovered ? 2 : 1),
                  ),
                ],
              ),
              transform: Matrix4.identity()
                ..scale(_isButtonHovered ? 1.03 : 1.0), // Subtle scale
              child: Text(
                'Start Planning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14, // Smaller font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the dotted flight path (made more subtle)
class DottedPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3) // More transparent
      ..strokeWidth = 2 // Thinner line
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.25,
      size.width,
      size.height / 2,
    );

    final dashPaint = Paint()
      ..color = Colors.white.withOpacity(0.5) // More transparent
      ..strokeWidth = 1 // Thinner line
      ..style = PaintingStyle.stroke;

    final dashPath = Path();
    double dashWidth = 3; // Smaller dashes
    double dashSpace = 3; // Smaller spacing
    double distance = 0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
