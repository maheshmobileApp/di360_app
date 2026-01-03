import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatefulWidget {
  final String title;
  final bool isRequired;
  final List<T> options;
  final T? selectedValue;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Axis direction;
  final bool readOnly; // Row or Column layout

  const CustomRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.labelBuilder,
    required this.onChanged,
    this.selectedValue,
    this.isRequired = false,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
    this.direction = Axis.horizontal,
    this.readOnly = false, // default row layout
  });

  @override
  State<CustomRadioGroup<T>> createState() => _CustomRadioGroupState<T>();
}

class _CustomRadioGroupState<T> extends State<CustomRadioGroup<T>> {
  T? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyles.regular3(color: AppColors.black),
            ),
            if (widget.isRequired)
              const Text(
                " *",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Flex(
          direction: Axis.horizontal,
          children: widget.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<T>(
                  
                    value: option,
                    groupValue: _groupValue,
                    activeColor: widget.activeColor,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => states.contains(MaterialState.selected)
                          ? widget.activeColor
                          : widget.inactiveColor,
                    ),
                    onChanged: widget.readOnly ? null : (val) {
                      setState(() {
                        _groupValue = val;
                      });
                      widget.onChanged(val as T);
                    },
                  ),
                  Text(
                    widget.labelBuilder(option),
                    style: TextStyle(
                      color: widget.readOnly ? AppColors.lightGeryColor : AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
