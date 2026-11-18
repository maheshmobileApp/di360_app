import 'package:flutter/material.dart';

class SearchFilterWidget extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onSearchChanged;

  const SearchFilterWidget({
    super.key,
    required this.searchController,
    required this.onFilterTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF8A9AAF),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E4EA),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E4EA),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        SizedBox(
          height: 56,
          child: OutlinedButton.icon(
            onPressed: onFilterTap,
            icon: const Icon(Icons.tune),
            label: const Text('Filters'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17324D),
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Color(0xFFE0E4EA),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
