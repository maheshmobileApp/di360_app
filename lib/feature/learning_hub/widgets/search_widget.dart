import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSearch;

  const SearchWidget({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            // 🔍 Search Icon
            const Icon(Icons.search, color: Colors.grey),

            const SizedBox(width: 8),

            // 📝 Text Field
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                textInputAction:
                    TextInputAction.search, // shows search icon on keyboard
                onSubmitted: (_) {
                  // ✅ Trigger search when user presses "Search" or "Done"
                  if (onSearch != null) onSearch!();
                },

                decoration: InputDecoration(
                    hintText: hintText, border: InputBorder.none),
              ),
            ),

            // ❌ Clear button
            if (controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.clear();
                  if (onClear != null) onClear!();
                  if (onChanged != null) onChanged!("");
                },
              ),

            // 🔎 Search button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onPressed: onSearch,
              label: const Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
