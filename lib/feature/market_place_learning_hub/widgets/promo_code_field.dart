
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PromoCodeField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onApply;
  final bool isLoading;

  const PromoCodeField({
    super.key,
    required this.controller,
    required this.onApply,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
   

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Promo Code",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF192235),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFE1E5EB),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textCapitalization:
                        TextCapitalization.characters,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (!isLoading && value.trim().isNotEmpty) {
                        onApply(value.trim());
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter promo code",
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final code = controller.text.trim();
                              if (code.isNotEmpty) {
                                onApply(code);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Apply",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
