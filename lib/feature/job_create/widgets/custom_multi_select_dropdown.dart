import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectDropDown<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel;
  final Function(List<T>) onSelectionChanged;
  final String hintText;
  final bool Function(T)? greyOutCondition;
  final double? height;
  final bool showOptions;

  const CustomMultiSelectDropDown({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
    required this.onSelectionChanged,
    required this.hintText,
    this.greyOutCondition,
    this.height,
    this.showOptions = false,
  }) : super(key: key);

  @override
  State<CustomMultiSelectDropDown<T>> createState() =>
      _CustomMultiSelectDropDownState<T>();
}

class _CustomMultiSelectDropDownState<T>
    extends State<CustomMultiSelectDropDown<T>> {
  List<T> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List<T>.from(widget.selectedItems);
  }

  @override
  void didUpdateWidget(covariant CustomMultiSelectDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selected = List<T>.from(widget.selectedItems);
  }

  void _toggleDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppColors.whiteColor,
              title: Text(
                widget.hintText,
                style: TextStyles.bold3(color: AppColors.black),
              ),
              content: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              setStateDialog(() {
                                _selected = List<T>.from(widget.items);
                              });
                            },
                            child: Text('Select All',
                                style: TextStyles.semiBold(
                                    color: AppColors.primaryColor,
                                    fontSize: 14)),
                          ),
                          TextButton(
                            onPressed: () {
                              setStateDialog(() {
                                _selected.clear();
                              });
                            },
                            child: Text('Clear All',
                                style: TextStyles.semiBold(
                                    color: AppColors.primaryColor,
                                    fontSize: 14)),
                          ),
                        ],
                      ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final isSelected = _selected.contains(item);
                          return CheckboxListTile(
                            dense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            activeColor: AppColors.primaryColor,
                            value: isSelected,
                            title: Text(
                              widget.itemLabel(item),
                              style: TextStyles.regular3(
                                color:
                                    _getItemColor(item, _selected, isSelected),
                              ),
                            ),
                            onChanged: (checked) {
                              setStateDialog(() {
                                if (checked == true) {
                                  // Handle Locum exclusivity
                                  if (widget.itemLabel(item) == "Locum") {
                                    // If Locum is selected, clear all others
                                    _selected.clear();
                                    _selected.add(item);
                                  } else {
                                    // If other item is selected, remove Locum if present
                                    _selected.removeWhere((selectedItem) =>
                                        widget.itemLabel(selectedItem) ==
                                        "Locum");
                                    _selected.add(item);
                                  }
                                } else {
                                  _selected.remove(item);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyles.semiBold(
                        color: AppColors.black, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onSelectionChanged(List<T>.from(_selected));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyles.semiBold(
                        color: AppColors.black, fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getItemColor(T item, List<T> currentSelection, bool isSelected) {
    if (widget.greyOutCondition != null) {
      // Apply grey out logic based on current dialog selection
      if (currentSelection.isEmpty) {
        return isSelected ? AppColors.primaryColor : AppColors.black;
      }

      final hasLocum = currentSelection
          .any((selected) => widget.itemLabel(selected) == "Locum");
      final isLocum = widget.itemLabel(item) == "Locum";

      if (hasLocum && !isLocum) {
        return Colors.grey; // Grey out non-Locum when Locum is selected
      } else if (!hasLocum && isLocum && currentSelection.isNotEmpty) {
        return Colors.grey; // Grey out Locum when other items are selected
      }
    }

    return isSelected ? AppColors.primaryColor : AppColors.black;
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _selected.isEmpty
        ? widget.hintText
        : _selected.map((e) => widget.itemLabel(e)).join(", ");
    return InkWell(
      onTap: _toggleDropdown,
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.geryColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                displayText,
                style: TextStyles.regular3(
                  color:
                      _selected.isEmpty ? AppColors.geryColor : AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
