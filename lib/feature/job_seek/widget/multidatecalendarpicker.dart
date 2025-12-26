import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class MultiDateCalendarPicker extends StatefulWidget {
  final List<DateTime> selectedDates;
  final Function(List<DateTime>) onDatesChanged;
  final TextEditingController controller;
  final String title;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const MultiDateCalendarPicker({
    Key? key,
    required this.selectedDates,
    required this.onDatesChanged,
    required this.controller,
    this.title = "Availability Date",
    this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<MultiDateCalendarPicker> createState() =>
      _MultiDateCalendarPickerState();
}

class _MultiDateCalendarPickerState extends State<MultiDateCalendarPicker> {
  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _daysInMonth(DateTime m) =>
      DateUtils.getDaysInMonth(m.year, m.month);

  int _startOffset(DateTime m) {
    final wd = DateTime(m.year, m.month, 1).weekday % 7;
    return wd; // Sunday start
  }

  Future<void> _openMultiSelectDialog(BuildContext context) async {
    List<DateTime> tempSelected = List.from(widget.selectedDates);
    DateTime focusedMonth = widget.initialDate != null
        ? DateTime(widget.initialDate!.year, widget.initialDate!.month)
        : widget.selectedDates.isNotEmpty
        ? DateTime(widget.selectedDates.last.year, widget.selectedDates.last.month)
        : DateTime(DateTime.now().year, DateTime.now().month);

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            final accent = Colors.orange;

            Widget dayCell(DateTime date) {
              final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              final firstDate = widget.firstDate ?? today;
              final lastDate = widget.lastDate;
              final isPast = date.isBefore(firstDate);
              final isFuture = lastDate != null && date.isAfter(lastDate);
              final isDisabled = isPast || isFuture;
              final isSelected = tempSelected.any((d) => _isSameDate(d, date));
              
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: isDisabled ? null : () {
                  setDialogState(() {
                    if (isSelected) {
                      tempSelected.removeWhere((d) => _isSameDate(d, date));
                    } else {
                      tempSelected.add(date);
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? accent : (isDisabled ? Colors.grey[200] : Colors.transparent),
                    border: Border.all(
                      color: isDisabled ? Colors.grey : (isSelected ? accent : Colors.black26),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : (isDisabled ? Colors.grey : Colors.black),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }

            final totalDays = _daysInMonth(focusedMonth);
            final offset = _startOffset(focusedMonth);
            final itemCount = offset + totalDays;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                "Select Availability Dates",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
              ),
              content: SizedBox(
                width: 330,
                height: 420,
                child: Column(
                  children: [
                    // Month header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            setDialogState(() {
                              focusedMonth = DateTime(
                                  focusedMonth.year, focusedMonth.month - 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat('MMMM yyyy').format(focusedMonth),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            setDialogState(() {
                              focusedMonth = DateTime(
                                  focusedMonth.year, focusedMonth.month + 1);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Weekdays row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _Dow('S'), _Dow('M'), _Dow('T'), _Dow('W'),
                        _Dow('T'), _Dow('F'), _Dow('S'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                        itemCount: itemCount,
                        itemBuilder: (_, i) {
                          if (i < offset) {
                            return const SizedBox.shrink();
                          }
                          final day = i - offset + 1;
                          final date = DateTime(
                              focusedMonth.year, focusedMonth.month, day);
                          return dayCell(date);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    tempSelected.sort((a, b) => a.compareTo(b));
                    widget.onDatesChanged(tempSelected);

                    if (tempSelected.isEmpty) {
                      widget.controller.clear();
                    } else {
                      widget.controller.text = tempSelected
                          .map((d) => DateFormat('MMM d, yyyy').format(d))
                          .join(", ");
                    }
                    Navigator.pop(ctx);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _openMultiSelectDialog(context),
      decoration: InputDecoration(
        labelText: widget.title,
        prefixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
        suffixIcon: const Icon(Icons.arrow_drop_down),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 0),
        hintText: "Select dates",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1.5, color: Colors.grey),
        ),
      ),
    );
  }
}

class _Dow extends StatelessWidget {
  final String t;
  const _Dow(this.t);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
