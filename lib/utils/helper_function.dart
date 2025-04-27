import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  try {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);
    
    // Format the date to show only year, month, and day
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  } catch (e) {
    // Handle any errors
    print("Error formatting date: $e");
    return inputDate; // Return the original input in case of error
  }
}
