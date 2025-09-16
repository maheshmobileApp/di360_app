import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CustomSelectField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const CustomSelectField({
    Key? key,
    required this.hint,
    this.value,
    required this.items,
    this.enabled = true,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = value ?? hint;
    final isPlaceholder = value == null;

    return GestureDetector(
      onTap: enabled
          ? () async {
              final picked = await _showSelectionDialog(context, items, hint);
              if (picked != null) onChanged(picked);
            }
          : null,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: enabled ? AppColors.HINT_COLOR : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  display,
                  style: isPlaceholder
                      ? TextStyles.regular3(color: AppColors.geryColor)
                      : TextStyles.regular3(color: AppColors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.geryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showSelectionDialog(
      BuildContext context, List<String> items, String title) {
    return showDialog<String>(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.5,
              minWidth: 260,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(title, style: TextStyles.regular3()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (c, i) {
                      final item = items[i];
                      return ListTile(
                        title: Text(item, style: TextStyles.regular3()),
                        onTap: () => Navigator.pop(ctx, item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
