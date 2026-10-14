import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_search_field.dart';
import 'package:flutter/material.dart';

class FilterOptionsList extends StatefulWidget {
  final List<String> options;
  final Set<String> selected;
  final String searchHint;
  final ValueChanged<String> onToggle;

  const FilterOptionsList({
    super.key,
    required this.options,
    required this.selected,
    required this.searchHint,
    required this.onToggle,
  });

  @override
  State<FilterOptionsList> createState() =>
      _FilterOptionsListState();
}

class _FilterOptionsListState extends State<FilterOptionsList> {
  final searchController = TextEditingController();
  String search = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOptions = widget.options.where((option) {
      return option.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Column(
        children: [
          FilterSearchField(
            controller: searchController,
            hint: widget.searchHint,
            onChanged: (value) {
              setState(() => search = value);
            },
          ),
          const SizedBox(height: 12),
          if (filteredOptions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "No options found",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ...filteredOptions.map(
            (option) => CheckboxListTile(
              value: widget.selected.contains(option),
              onChanged: (_) => widget.onToggle(option),
              title: Text(
                option,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.black,
                ),
              ),
              activeColor: AppColors.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              side: const BorderSide(
                color: Color(0xFFB6C1D3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}