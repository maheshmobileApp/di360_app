import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AvailabilityCalendarDialog extends StatefulWidget {
  final String availabilityType;
  final List<String> availabilityDays;
  final List<String> availabilityDates;
  final String? title;

  const AvailabilityCalendarDialog({
    Key? key,
    required this.availabilityType,
    required this.availabilityDays,
    required this.availabilityDates,
    this.title,
  }) : super(key: key);

  factory AvailabilityCalendarDialog.fromJobProfile(dynamic jobProfile, {String? title}) {
    final rawType =
        (jobProfile?.availabilityType ?? '').toString().toLowerCase();
    final hasDates =
        (jobProfile?.availabilityDate as List?)?.isNotEmpty == true;
    final hasDays = (jobProfile?.availabilityDay as List?)?.isNotEmpty == true;

    String resolvedType;
    if (['days', 'dates', 'both'].contains(rawType)) {
      resolvedType = rawType;
    } else if (hasDates && hasDays) {
      resolvedType = 'both';
    } else if (hasDates) {
      resolvedType = 'dates';
    } else if (hasDays) {
      resolvedType = 'days';
    } else {
      resolvedType = 'none';
    }

    final daysList = (jobProfile?.availabilityDay as List?)
            ?.map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        <String>[];
    final datesList = (jobProfile?.availabilityDate as List?)
            ?.map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        <String>[];

    return AvailabilityCalendarDialog(
      availabilityType: resolvedType,
      availabilityDays: daysList,
      availabilityDates: datesList,
      title: title,
    );
  }

  @override
  State<AvailabilityCalendarDialog> createState() =>
      _AvailabilityCalendarDialogState();
}

class _AvailabilityCalendarDialogState
    extends State<AvailabilityCalendarDialog> {
  DateTime _focusedDay = DateTime.now();
  late final Set<DateTime> _apiDates;
  late final Set<String> _availabilityDaySet;

  @override
  void initState() {
    super.initState();
    _apiDates = widget.availabilityDates
        .map((s) => parseDateString(s))
        .whereType<DateTime>()
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    _availabilityDaySet = widget.availabilityDays
        .map((s) => weekdayNameNormalized(s))
        .where((s) => s.isNotEmpty)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              widget.title ?? "Availability",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.primaryColor,
              ),
            ),
            const Divider(height: 1),
            Expanded(child: _buildAvailabilityTab()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityTab() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final normalizedDay = DateTime(day.year, day.month, day.day);
          bool highlight = false;
          if (widget.availabilityType == 'days' ||
              widget.availabilityType == 'both') {
            final weekdayFull = weekdayName(day.weekday).toLowerCase();
            if (_availabilityDaySet.contains(weekdayFull)) highlight = true;
          }

          if (!highlight &&
              (widget.availabilityType == 'dates' ||
                  widget.availabilityType == 'both')) {
            if (_apiDates.contains(normalizedDay)) highlight = true;
          }

          if (highlight) return _buildHighlightedCell(day);
          return null;
        },
      ),
      selectedDayPredicate: (_) => false,
      onDaySelected: (_, __) {},
      onPageChanged: (focusedDay) {
        setState(() => _focusedDay = focusedDay);
      },
    );
  }

  Widget _buildHighlightedCell(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: const TextStyle(color: AppColors.whiteColor),
      ),
    );
  }
}

DateTime? parseDateString(String? s) {
  if (s == null) return null;
  final trimmed = s.trim();
  if (trimmed.isEmpty) return null;

  final iso = DateTime.tryParse(trimmed);
  if (iso != null) return DateTime(iso.year, iso.month, iso.day);

  final re = RegExp(r'^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})$');
  final m = re.firstMatch(trimmed);
  if (m != null) {
    final d = int.tryParse(m.group(1)!)!;
    final mo = int.tryParse(m.group(2)!)!;
    final y = int.tryParse(m.group(3)!)!;
    return DateTime(y, mo, d);
  }

  final dateKeyRe = RegExp(r'(\d{4})[\/\-](\d{1,2})[\/\-](\d{1,2})');
  final m2 = dateKeyRe.firstMatch(trimmed);
  if (m2 != null) {
    final y = int.parse(m2.group(1)!);
    final mo = int.parse(m2.group(2)!);
    final d = int.parse(m2.group(3)!);
    return DateTime(y, mo, d);
  }

  return null;
}

String weekdayNameNormalized(String input) {
  final s = input.toLowerCase().trim();
  if (s.isEmpty) return '';
  if (s.startsWith('mon')) return 'monday';
  if (s.startsWith('tue')) return 'tuesday';
  if (s.startsWith('wed')) return 'wednesday';
  if (s.startsWith('thu')) return 'thursday';
  if (s.startsWith('fri')) return 'friday';
  if (s.startsWith('sat')) return 'saturday';
  if (s.startsWith('sun')) return 'sunday';
  return s;
}

String weekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Monday";
    case DateTime.tuesday:
      return "Tuesday";
    case DateTime.wednesday:
      return "Wednesday";
    case DateTime.thursday:
      return "Thursday";
    case DateTime.friday:
      return "Friday";
    case DateTime.saturday:
      return "Saturday";
    case DateTime.sunday:
      return "Sunday";
    default:
      return "";
  }
}

int weekdayIndex(String weekdayLower) {
  switch (weekdayLower) {
    case 'monday':
      return 1;
    case 'tuesday':
      return 2;
    case 'wednesday':
      return 3;
    case 'thursday':
      return 4;
    case 'friday':
      return 5;
    case 'saturday':
      return 6;
    case 'sunday':
      return 7;
  }
  return 99;
}
