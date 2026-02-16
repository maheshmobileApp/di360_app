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
    // Replace all Unicode whitespace (including non-breaking spaces) with a normal space and trim
    final cleaned =
        time.replaceAll(RegExp(r'\s+'), ' ').replaceAll('\u00A0', ' ').trim();
    try {
      final dateFormat = DateFormat.jm();
      final dateTime = dateFormat.parse(cleaned);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      // Optionally log or handle the error, then return the original string or a fallback
      return time;
    }
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

  static String formatToAmPm(String timeString) {
  // Add a dummy date to make it a valid ISO format
  String withDate = "1970-01-01T$timeString";

  DateTime dt = DateTime.parse(withDate);
  return DateFormat('hh:mm a').format(dt);
}

static String formatDateTime(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    final localDateTime = dateTime.toLocal();
    return DateFormat('dd-MM-yyyy hh:mm a').format(localDateTime);
  } catch (e) {
    return dateTimeString; // Return original if parsing fails
  }
}

static String formatDate(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    final localDateTime = dateTime.toLocal();
    return DateFormat('dd-MM-yyyy').format(localDateTime);
  } catch (e) {
    return dateTimeString; // Return original if parsing fails
  }
}

static String formatToTime(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    final originalTime = dateTime.add(dateTime.timeZoneOffset);
    return DateFormat('hh:mm a').format(originalTime);
  } catch (e) {
    return dateTimeString; // Return original if parsing fails
  }
}

static String formatDateYear(String dateTimeString) {
  try {
    DateTime dateTime;
    // Try parsing as ISO format first
    try {
      dateTime = DateTime.parse(dateTimeString);
    } catch (e) {
      // If ISO parsing fails, try DD/M/YYYY or DD/MM/YYYY format
      final parts = dateTimeString.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        dateTime = DateTime(year, month, day);
      } else {
        return dateTimeString;
      }
    }
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } catch (e) {
    return dateTimeString; // Return original if parsing fails
  }
}

static String formatDateToIso8601(String dateString) {
  try {
    DateTime dateTime;
    // Try parsing DD/MM/YYYY or DD/M/YYYY format
    final parts = dateString.split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      dateTime = DateTime(year, month, day);
      return dateTime.toUtc().toIso8601String();
    }
    // Try parsing as ISO format
    dateTime = DateTime.parse(dateString);
    return dateTime.toUtc().toIso8601String();
  } catch (e) {
    return dateString;
  }
}

static String formatYyyyMmDdToDdMmYyyy(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  } catch (e) {
    return dateString;
  }
}
}
