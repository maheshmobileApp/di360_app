import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final vm = Provider.of<MarketPlaceLearningHubViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Apply Promocode",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF192235),
            ),
          ),
          const SizedBox(height: 8),
          vm.promoCodeRes?.promoId != null
              ? Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE1E5EB),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" '${vm.promoCodeRes?.promoCode}' applied",
                            style: TextStyles.medium2(
                                color: AppColors.greenColor)),
                        GestureDetector(
                          onTap: () {
                            vm.removePromoCode();
                            
                          },
                          child: Text(
                            "Remove",
                            style: TextStyles.regular1(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                color: AppColors.redColor),
                          ),
                        )
                      ],
                    ),
                  ))
              : Container(
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
                          textCapitalization: TextCapitalization.characters,
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
                                : Text(
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
