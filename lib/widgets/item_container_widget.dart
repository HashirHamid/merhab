
import 'package:flutter/material.dart';
import 'package:merhab/theme/themes.dart';

class ItemContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  const ItemContainer({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.darkGreenColor.withAlpha(30),
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkGreenColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 15,),
                Icon(Icons.arrow_forward_sharp,
                    color: AppTheme.darkGreenColor),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
