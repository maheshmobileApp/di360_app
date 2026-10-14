import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/supplies/model/filter_category.dart';
import 'package:flutter/material.dart';

class NestedCategoryFilter extends StatefulWidget {
  final List<FilterCategory> categories;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  const NestedCategoryFilter({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onChanged,
  });

  @override
  State<NestedCategoryFilter> createState() =>
      _NestedCategoryFilterState();
}

class _NestedCategoryFilterState extends State<NestedCategoryFilter> {
  final TextEditingController searchController =
      TextEditingController();

  final Set<String> expandedIds = {};
  String search = '';

  // Get all IDs under a category, including parent.
  Set<String> getAllIds(FilterCategory category) {
    return {
      category.id,
      for (final child in category.children) ...getAllIds(child),
    };
  }

  void toggleCategory(FilterCategory category, bool selected) {
    final updated = {...widget.selectedIds};
    final ids = getAllIds(category);

    if (selected) {
      updated.addAll(ids);
    } else {
      updated.removeAll(ids);
    }

    widget.onChanged(updated);
  }

  bool isSelected(FilterCategory category) {
    final ids = getAllIds(category);
    return ids.every(widget.selectedIds.contains);
  }

  bool isPartiallySelected(FilterCategory category) {
    final ids = getAllIds(category);
    return ids.any(widget.selectedIds.contains) &&
        !ids.every(widget.selectedIds.contains);
  }

  bool matchesSearch(FilterCategory category) {
    if (category.name.toLowerCase().contains(search)) {
      return true;
    }

    return category.children.any(matchesSearch);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = widget.categories
        .where(matchesSearch)
        .toList();

    return Column(
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                search = value.trim().toLowerCase();
              });
            },
            decoration: InputDecoration(
          hintText: "Search categories...",
          hintStyle: const TextStyle(
            color: Color(0xFF9CA8C5),
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
            size: 19,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Color(0xFFDADDE3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: Color(0xFFDADDE3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
          ),
        ),

        // Scrollable Category List
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 280,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredCategories.length,
            itemBuilder: (context, index) {
              return buildCategory(
                filteredCategories[index],
                0,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategory(FilterCategory category, int level) {
    final hasChildren = category.children.isNotEmpty;

    final isExpanded =
        expandedIds.contains(category.id) || search.isNotEmpty;

    final selected = isSelected(category);
    final partial = isPartiallySelected(category);

    final visibleChildren = category.children
        .where((child) =>
            search.isEmpty ||
            category.name.toLowerCase().contains(search) ||
            matchesSearch(child))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 12.0 + (level * 24),
            right: 12,
          ),
          child: Row(
            children: [
              // Expand / Collapse
              SizedBox(
                width: 26,
                child: hasChildren
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            if (expandedIds.contains(category.id)) {
                              expandedIds.remove(category.id);
                            } else {
                              expandedIds.add(category.id);
                            }
                          });
                        },
                        child: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          size: 19,
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox(),
              ),

              // Checkbox
              Checkbox(
                value: partial ? null : selected,
                tristate: true,
                activeColor: const Color(0xFFFF6500),
                visualDensity: VisualDensity.compact,
                onChanged: (_) {
                  toggleCategory(category, !selected);
                },
              ),

              // Category Name
              Expanded(
                child: InkWell(
                  onTap: () {
                    toggleCategory(category, !selected);
                  },
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: level == 0
                          ? const Color(0xFF526582)
                          : const Color(0xFF555555),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Subcategories
        if (hasChildren && isExpanded)
          ...visibleChildren.map(
            (child) => buildCategory(child, level + 1),
          ),
      ],
    );
  }
}