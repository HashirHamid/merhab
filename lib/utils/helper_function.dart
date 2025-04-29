import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merhab/utils/app_images.dart';

String formatDate(String inputDate) {
  try {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  } catch (e) {
    print("Error formatting date: $e");
    return inputDate;
  }
}

List<String> splitIntoLines(String text, int wordsPerLine) {
  final words = text.split(' ');
  final lines = <String>[];

  for (int i = 0; i < words.length; i += wordsPerLine) {
    lines.add(words.skip(i).take(wordsPerLine).join(' '));
  }

  return lines;
}

String formatTimeZone(String? startDate) {
  if (startDate == null) return "";
  DateTime dateTime = DateTime.parse(startDate);
  return "${dateTime.hour > 12 ? 'PM' : 'AM'}";
}

String getActivityImagePath(String activityType) {
  final Map<String, String> activityIcons = {
    'Sightseeing Tour': AppImages.sightseeingIcon,
    'Nature Hike/Adventure Trekking': AppImages.hikingIcon,
    'Cultural Experiences': AppImages.cultureIcon,
    'Beach Day/Water Sports': AppImages.beachdayIcon,
    'Food Tour': AppImages.foodIcon,
    'Wildlife Safari': AppImages.wildlifeIcon,
    'Sunset/Sunrise Viewing': AppImages.sunriseIcon,
  };

  return activityIcons[activityType] ?? "Sightseeing Tour";
}

enum DateFormatStyle {
  fullRangeWithLowercaseDayMonth,
  singleDayWithComma,
  fullRangeWithDayMonthYear,
  shortMonthWithRange,
  singleDayFormat,
  shortDayMonth,
}

String formatDateByStyle({
  String? startDate,
  String? endDate,
  DateFormatStyle? style,
}) {
  final now = DateTime.now();

  final DateTime start = startDate != null && startDate.isNotEmpty
      ? DateTime.tryParse(startDate) ?? now
      : now;

  final DateTime end = endDate != null && endDate.isNotEmpty
      ? DateTime.tryParse(endDate) ?? now
      : now;

  final selectedStyle = style ?? DateFormatStyle.fullRangeWithDayMonthYear;

  switch (selectedStyle) {
    case DateFormatStyle.fullRangeWithLowercaseDayMonth:
      final startFormatted =
          DateFormat('EEEE MMMM d').format(start).toLowerCase();
      final endFormatted = DateFormat('EEEE MMMM d').format(end).toLowerCase();
      final year = DateFormat('y').format(end);
      return '$startFormatted - $endFormatted $year';

    case DateFormatStyle.singleDayWithComma:
      final formatted = DateFormat('EEEE, MMMM d').format(start);
      return formatted.toLowerCase();

    case DateFormatStyle.fullRangeWithDayMonthYear:
      final startFormatted = DateFormat('EEEE MMMM d').format(start);
      final endFormatted = DateFormat('EEEE MMMM d').format(end);
      final year = DateFormat('y').format(end);
      return '$startFormatted - $endFormatted $year';

    case DateFormatStyle.shortMonthWithRange:
      final startFormatted = DateFormat('MMM d').format(start);
      final endFormatted = DateFormat('MMM d').format(end);
      final year = DateFormat('y').format(end);
      return '$startFormatted - $endFormatted, $year';

    case DateFormatStyle.singleDayFormat:
      return DateFormat('EEEE, MMMM d, y').format(start);

    case DateFormatStyle.shortDayMonth:
      return DateFormat('EEE, MMM d').format(start);
  }
}


String formatTimeWithAmPm(TimeOfDay time) {

  final int hour = time.hour;
  final int minute = time.minute;

  String amPm = hour < 12 ? "AM" : "PM";

  String formattedHour = hour > 12 ? (hour - 12).toString() : (hour == 0 ? "12" : hour.toString());

  String formattedMinute = minute.toString().padLeft(2, '0');

  return "$formattedHour:$formattedMinute $amPm";
}
TimeOfDay parseTimeOfDayString(String timeString) {
  // Define the regex pattern to extract hour and minute
  final RegExp regExp = RegExp(r"TimeOfDay\((\d{1,2}):(\d{2})\)");

  // Match the string with the regex
  final match = regExp.firstMatch(timeString);

  if (match != null) {
    // Extract hour and minute from the match
    final int hour = int.parse(match.group(1)!);
    final int minute = int.parse(match.group(2)!);

    // Return the TimeOfDay object
    return TimeOfDay(hour: hour, minute: minute);
  } else {
    // Return a default time if the string does not match the pattern
    throw FormatException("Invalid time string format");
  }
}
