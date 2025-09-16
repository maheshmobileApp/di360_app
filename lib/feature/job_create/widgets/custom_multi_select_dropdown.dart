
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';


class CustomMultiSelectDropDown<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel;
  final Function(List<T>) onSelectionChanged;
  final String hintText;

  const CustomMultiSelectDropDown({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
    required this.onSelectionChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CustomMultiSelectDropDown<T>> createState() =>
      _CustomMultiSelectDropDownState<T>();
}

class _CustomMultiSelectDropDownState<T>
    extends State<CustomMultiSelectDropDown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
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
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _closeDropdown();
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        width: size.width,
        top: offset.dy + size.height,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: StatefulBuilder(
                builder: (context, setStateOverlay) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
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
                            color: isSelected ? AppColors.primaryColor: AppColors.black,
                          ),
                        ),
                        onChanged: (checked) {
                          setStateOverlay(() {
                            if (checked == true) {
                              _selected.add(item);
                            } else {
                              _selected.remove(item);
                            }
                          });
                          setState(() {
                            widget.onSelectionChanged(List<T>.from(_selected));
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _selected.isEmpty
        ? widget.hintText
        : _selected.map((e) => widget.itemLabel(e)).join(", ");
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: Container(
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
                    color: _selected.isEmpty ? AppColors.geryColor : AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.black),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }
}
