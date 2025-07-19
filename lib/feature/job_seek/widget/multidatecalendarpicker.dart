
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MultiDateCalendarPicker extends StatefulWidget {
  final List<DateTime> selectedDates;
  final Function(DateTime) onToggleDate;
  final String title;

  const MultiDateCalendarPicker({
    Key? key,
    required this.selectedDates,
    required this.onToggleDate,
    this.title = "Availability Date",
  }) : super(key: key);

  @override
  State<MultiDateCalendarPicker> createState() =>
      _MultiDateCalendarPickerState();
}

class _MultiDateCalendarPickerState extends State<MultiDateCalendarPicker> {
  DateTime currentMonth = DateTime.now();
  bool showCalendar = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _updateTextFromDates();
  }

  void _updateTextFromDates() {
    controller.text = widget.selectedDates
        .map((d) => DateFormat('d/M/yyyy').format(d))
        .join(" | ");
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  void didUpdateWidget(covariant MultiDateCalendarPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDates != widget.selectedDates) {
      _updateTextFromDates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () {
            setState(() {
              showCalendar = !showCalendar;
            });
          },
          decoration: InputDecoration(
            labelText: widget.title,
            prefixIcon: const Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 0),
            hintText: "Select dates",
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5, color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(width: 1.5, color: Colors.black12),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
        ),
        if (showCalendar) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    currentMonth = DateTime(
                      currentMonth.year,
                      currentMonth.month - 1,
                    );
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(currentMonth),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    currentMonth = DateTime(
                      currentMonth.year,
                      currentMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: DateUtils.getDaysInMonth(
              currentMonth.year,
              currentMonth.month,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final date = DateTime(currentMonth.year, currentMonth.month, index + 1);
              final isSelected =
                  widget.selectedDates.any((d) => isSameDay(d, date));

              return GestureDetector(
                onTap: () {
                  widget.onToggleDate(date);
                  _updateTextFromDates(); 
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isSelected ? Colors.deepOrange : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? Colors.deepOrange : Colors.black26,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ]
      ],
    );
  }
}
