import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppDateTimeHelper {
  static String processDateTime(String responseBody) {
    // Find the position of the '+' character
    int plusIndex = responseBody.indexOf('+');

    if (plusIndex != -1) {
      // Remove characters after the '+' character
      String cleanedResponse = responseBody.substring(0, plusIndex);

      // print("Original Response Body: $responseBody");
      // print("Cleaned Response Body: $cleanedResponse");
      return cleanedResponse;
    } else {
      // print("No '+' character found in the response body.");
      return DateTime.now().toIso8601String();
    }
  }

  static String formatTimeDifference(String dateStr) {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse(dateStr);

    Duration difference = now.difference(parsedDate);
    int minutes = difference.inMinutes;
    int hours = difference.inHours;

    if (difference.inMinutes < 30) {
      return 'Baru Saja';
    } else if (minutes < 60) {
      return '$minutes Menit yang lalu';
    } else if (hours < 24) {
      return '$hours Jam yang lalu';
    } else {
      // String formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(parsedDate);
      String formattedDate = DateFormat('d MMMM yyyy').format(parsedDate);
      return formattedDate;
    }
  }

  Future<DateTimeRange?> dateRangePicker(
    BuildContext context,{
      DateTime? startDate,
      DateTime? endDate,
    }
  ) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: startDate ?? DateTime.now().subtract(const Duration(days: 1)),
        end: endDate ?? DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff4F54DE),
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff4F54DE),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 330.w,
                  maxHeight: 550.h,
                ),
                child: child,
              )
            ],
          ),
        );
      },
    );
  }
}
