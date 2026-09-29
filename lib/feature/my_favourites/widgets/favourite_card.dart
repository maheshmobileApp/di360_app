import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class FavouriteCard extends StatelessWidget {
  final bool isSelected;
  final String productId;
  final String productName;
  final String companyName;
  final String addedOn;
  final String availability;
  final String price;
  final int quantity;
  final String? imageUrl;

  final VoidCallback? onFavourite;
  final VoidCallback? onCartTap;
  final ValueChanged<String>? onMenuSelected;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final bool checkbox;
  final bool menuOptions;

  const FavouriteCard({
    super.key,
    required this.isSelected,
    required this.productId,
    required this.productName,
    required this.companyName,
    required this.addedOn,
    required this.availability,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.onFavourite,
    this.onCartTap,
    this.onMenuSelected,
    this.onIncrease,
    this.onDecrease,
    this.checkbox = true,
    this.menuOptions = true,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            /// Top Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onFavourite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                /// Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: NetworkImageWidget(
                    imageUrl: imageUrl ?? "",
                    fit: BoxFit.contain,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bold2(),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        companyName,
                        style: TextStyles.medium2(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Added on : ${DateFormatUtils.formatDateToDmy(addedOn)}",
                        style: TextStyles.medium2(
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: availability == "0"
                              ? Colors.red.shade100
                              : AppColors.greenColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          availability == "0" ? "Not Available" : "Available",
                          style: TextStyles.medium2(
                            color: availability == "0"
                                ? Colors.red.shade700
                                : AppColors.greenColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Divider(height: 1),
            ),

            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: QuantityStepper(
                    quantity: quantity,
                    onIncrease: onIncrease,
                    onDecrease: quantity > 1 ? onDecrease : null,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: onCartTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
