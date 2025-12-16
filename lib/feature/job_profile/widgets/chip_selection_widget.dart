
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';


class ChipTextField extends StatefulWidget {
  final String? title;
  final bool isRequired;
  final List<String> chips;
  final Function(List<String>) onChanged;
  final String? hintText;
  final double? borderRadius;
  final Color? fillColor;
  final bool? isFilled;
  final Color? borderColor;
  final FocusNode? focusNode;

  const ChipTextField({
    super.key,
    this.title,
    this.isRequired = false,
    required this.chips,
    required this.onChanged,
    this.hintText,
    this.borderRadius,
    this.fillColor,
    this.isFilled,
    this.borderColor,
    this.focusNode,
  });

  @override
  State<ChipTextField> createState() => _ChipTextFieldState();
}

class _ChipTextFieldState extends State<ChipTextField> {
  final TextEditingController _controller = TextEditingController();

  void _addChip(String text) {
    text = text.trim();
    if (text.isNotEmpty && !widget.chips.contains(text)) {
      setState(() => widget.chips.add(text));
      widget.onChanged(widget.chips);
    }
    _controller.clear();
  }

  void _removeChip(String chip) {
    setState(() => widget.chips.remove(chip));
    widget.onChanged(widget.chips);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title!,
                style: TextStyles.regular3(color: AppColors.black),
              ),
              if (widget.isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: widget.chips.isEmpty ? widget.hintText : "",
            hintStyle:
                TextStyles.regular4(color: AppColors.dropDownHint),
            filled: widget.isFilled ?? true,
            fillColor: widget.fillColor ?? Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide: BorderSide(
                width: 1.5,
                color: widget.borderColor ?? AppColors.inputBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide: BorderSide(
                width: 1.5,
                color: widget.borderColor ?? AppColors.HINT_COLOR,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.chips
                    .map((chip) => Chip(
                          label: Text(chip),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () => _removeChip(chip),
                          backgroundColor: (widget.borderColor ?? Colors.deepPurple)
                              .withOpacity(0.1),
                        ))
                    .toList(),
              ),
            ),
          ),
          onFieldSubmitted: (value) => _addChip(value),
          onChanged: (value) {
            if (value.endsWith(" ") || value.endsWith(",") || value.endsWith(";")) {
              _addChip(value.substring(0, value.length - 1));
            }
          },
        ),
      ],
    );
  }
}
