import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeField extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTimeRange?>? onChanged;

  const DateRangeField({
    super.key,
    this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
    this.onChanged,
  });

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedRange = widget.initialDateRange;
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDateRange: _selectedRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF344054),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF344054),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedRange = picked;
      });

      widget.onChanged?.call(picked);
    }
  }

  void _clearDateRange() {
    setState(() {
      _selectedRange = null;
    });

    widget.onChanged?.call(null);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _selectedRange != null;

    return GestureDetector(
      onTap: _selectDateRange,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color:  const Color.fromARGB(255, 66, 66, 66),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Date text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  hasValue
                      ? '${_formatDate(_selectedRange!.start)} – '
                          '${_formatDate(_selectedRange!.end)}'
                      : 'Select date range',
                  style: TextStyle(
                    fontSize: 15,
                    color: hasValue
                        ? const Color(0xFF344054)
                        : const Color(0xFF98A2B3),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // Calendar button
            Container(
              width: 60,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFE9EAEC),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 4),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 24,
                color: Color(0xFF667085),
              ),
            )

            /*GestureDetector(
              onTap: hasValue ? _clearDateRange : null,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: hasValue ? const Color(0xFF667085) : const Color(0xFFD0D5DD),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
