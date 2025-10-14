import 'package:intl/intl.dart';

class DateFormatUtils {
  /// Formats a [DateTime] to 'yyyy-MM-dd' (e.g., 2025-09-23)
  static String formatToYyyyMmDd(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Formats a [DateTime] to 'd MMM yyyy' (e.g., 23 Sep 2025)
  static String formatToDayMonthYear(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }

static String convertTo24Hour(String time) {
  // Clean up the input string
  final cleaned = time.replaceAll('\u00A0', ' ').trim(); // Replace non-breaking space with normal space
  final dateFormat = DateFormat.jm(); // or your format, e.g. 'hh:mm a'
  final dateTime = dateFormat.parse(cleaned);
  return DateFormat('HH:mm').format(dateTime);
}

  static String convertToddmmm(String date) {
    final dateTime = DateTime.parse(date);
    return DateFormat('dd MMM').format(dateTime);
  }

  static String formatToHourAmPm(String timeStr) {
    try {
      // Prepend a dummy date to make it a valid DateTime
      String isoStr = "2000-01-01T$timeStr";
      DateTime time = DateTime.parse(isoStr);

      // Convert to local time if needed
      DateTime localTime = time.toLocal();

      // Format as hour + AM/PM
      return DateFormat('h a').format(localTime);
    } catch (e) {
      return timeStr; // fallback
    }
  }
}
