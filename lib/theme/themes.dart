import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLavenderColor = Color(0xFFC9A2DD);
  static const Color secondaryLavenderColor = Color(0xFFDCC5F2);
  static const Color darkLavenderColor = Color.fromARGB(255, 164, 121, 186);
  static const Color primaryGreenColor = Color(0xFFA3E170);
  static const Color secondaryGreenColor = Color(0xFF4DAA41);
  static const Color darkGreenColor = Color(0xFF3C3929);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;
  static const Color greyTextColor = Colors.grey;
  static const Color errorColor = Color(0xFFDC3545);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLavenderColor,
    fontFamily: "Poppins",
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryLavenderColor,
      secondary: secondaryLavenderColor,
      error: errorColor,
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryLavenderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIconColor: Colors.grey,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLavenderColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLavenderColor,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: Colors.grey,
      size: 24,
    ),
  );
}
