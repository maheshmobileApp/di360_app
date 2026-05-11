import 'package:jiffy/jiffy.dart';

String jiffyDataWidget(String? date, {String? format}) {
  if (date == null || date.trim().isEmpty) return '';
  try {
    final parsed = Jiffy.parse(date, isUtc: true);
    return (format != null && format.isNotEmpty)
        ? parsed.format(pattern: format)
        : parsed.fromNow();
  } catch (_) {
    return '';
  }
}
