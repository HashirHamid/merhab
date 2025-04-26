import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/widgets/section_widget.dart';

class AboutSaudiPage extends StatelessWidget {
  const AboutSaudiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    )),
                const SizedBox(height: 16),
                const Text(
                  'About Saudi',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DiagonalSections(
                  sections: [
                    SectionData(
                      icon: Icons.brush,
                      title: 'Culture',
                      description: 'Welcome to the home section.',
                      backgroundColor: Colors.indigo,
                    ),
                    SectionData(
                      icon: Icons.language,
                      title: 'Language',
                      description: 'Learn more about us.',
                      backgroundColor: Colors.teal,
                      image: AssetImage('assets/transportation.png'),
                    ),
                    SectionData(
                      icon: Icons.gavel,
                      title: 'Law & Ettiquette',
                      description: 'Reach out to us anytime.',
                      backgroundColor: Colors.deepOrange,
                    ),
                    SectionData(
                      icon: Icons.mosque,
                      title: 'Religion',
                      description: 'Customize your experience.',
                      backgroundColor: Colors.deepPurple,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
