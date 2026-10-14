import 'package:di360_flutter/feature/supplies/widgets/filter_option_list.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_search_field.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_section.dart';
import 'package:flutter/material.dart';

const Color filterOrange = Color(0xFFFF6500);
const Color filterText = Color(0xFF25345C);

class ProductFilterResult {
  final String search;
  final List<String> brands;
  final List<String> categories;
  final List<String> suppliers;
  final List<String> promotions;
  final RangeValues? priceRange;

  const ProductFilterResult({
    required this.search,
    required this.brands,
    required this.categories,
    required this.suppliers,
    required this.promotions,
    this.priceRange,
  });
}

class ProductFilterScreen extends StatefulWidget {
  final List<String> brands;
  final List<String> categories;
  final List<String> suppliers;
  final List<String> promotions;
  final void Function(ProductFilterResult result)? onApply;

  const ProductFilterScreen({
    super.key,
    this.brands = const [],
    this.categories = const [],
    this.suppliers = const [],
    this.promotions = const [],
    this.onApply,
  });

  @override
  State<ProductFilterScreen> createState() =>
      _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  final searchController = TextEditingController();

  final Set<String> selectedBrands = {};
  final Set<String> selectedCategories = {};
  final Set<String> selectedSuppliers = {};
  final Set<String> selectedPromotions = {};

  RangeValues priceRange = const RangeValues(0, 10000);
  bool priceSelected = false;

  void toggleSelection(Set<String> selected, String value) {
    setState(() {
      if (!selected.add(value)) {
        selected.remove(value);
      }
    });
  }

  void resetFilters() {
    setState(() {
      searchController.clear();
      selectedBrands.clear();
      selectedCategories.clear();
      selectedSuppliers.clear();
      selectedPromotions.clear();
      priceRange = const RangeValues(0, 10000);
      priceSelected = false;
    });
  }

  void applyFilters() {
    final result = ProductFilterResult(
      search: searchController.text.trim(),
      brands: selectedBrands.toList(),
      categories: selectedCategories.toList(),
      suppliers: selectedSuppliers.toList(),
      promotions: selectedPromotions.toList(),
      priceRange: priceSelected ? priceRange : null,
    );

    if (widget.onApply != null) {
      widget.onApply!(result);
    } else {
      Navigator.pop(context, result);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFECEEF2)),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.filter_alt,
                      color: filterOrange, size: 22),
                  SizedBox(width: 12),
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: filterText,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilterSearchField(
                      controller: searchController,
                      hint: "Search products...",
                    ),
                  ),

                  FilterSection(
                    title: "Brand",
                    icon: Icons.local_offer,
                    initiallyExpanded: true,
                    child: FilterOptionsList(
                      options: widget.brands,
                      selected: selectedBrands,
                      searchHint: "Search brand...",
                      onToggle: (value) =>
                          toggleSelection(selectedBrands, value),
                    ),
                  ),

                  FilterSection(
                    title: "categories",
                    icon: Icons.grid_view,
                    child: FilterOptionsList(
                      options: widget.categories,
                      selected: selectedCategories,
                      searchHint: "Search categories...",
                      onToggle: (value) =>
                          toggleSelection(selectedCategories, value),
                    ),
                  ),

                  FilterSection(
                    title: "Suppliers",
                    icon: Icons.local_shipping,
                    child: FilterOptionsList(
                      options: widget.suppliers,
                      selected: selectedSuppliers,
                      searchHint: "Search suppliers...",
                      onToggle: (value) =>
                          toggleSelection(selectedSuppliers, value),
                    ),
                  ),

                  FilterSection(
                    title: "Price",
                    icon: Icons.sell,
                    trailing: !priceSelected
                        ? const Text(
                            "Any",
                            style: TextStyle(
                              color: filterOrange,
                              fontSize: 12,
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 10000,
                          divisions: 100,
                          activeColor: filterOrange,
                          labels: RangeLabels(
                            "₹${priceRange.start.round()}",
                            "₹${priceRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setState(() {
                              priceRange = values;
                              priceSelected = true;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₹${priceRange.start.round()}"),
                              Text("₹${priceRange.end.round()}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  FilterSection(
                    title: "Promotions",
                    icon: Icons.star_border,
                    child: FilterOptionsList(
                      options: widget.promotions,
                      selected: selectedPromotions,
                      searchHint: "Search promotions...",
                      onToggle: (value) =>
                          toggleSelection(selectedPromotions, value),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFECEEF2)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: applyFilters,
                      icon: const Icon(
                        Icons.filter_alt,
                        size: 17,
                      ),
                      label: const Text("Apply Filters"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: filterOrange,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: resetFilters,
                      icon: const Icon(
                        Icons.refresh,
                        size: 16,
                      ),
                      label: const Text("Reset"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: filterOrange,
                        side: const BorderSide(
                          color: filterOrange,
                        ),
                        minimumSize: const Size(0, 46),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}