import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/product_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onFavorite;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onDetailView;

  const ProductCard(
      {super.key,
      required this.product,
      this.onFavorite,
      this.onAddToCart,
      this.onIncrease,
      this.onDecrease,
      this.onDetailView});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onDetailView,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio:
                            1.5, // or another value matching your image's aspect ratio
                        child: NetworkImageWidget(
                          imageUrl: product.image ?? '',
                          fit: BoxFit.contain,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.medium2(),
                      ),
                      Text(
                        product.brand,
                        style: TextStyles.bold3(color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "AUD ",
                            style: TextStyles.medium2(),
                          ),
                          Text(
                            "${product.price}",
                            style: TextStyles.bold3(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.inStock ? "In Stock" : "Out of Stock",
                        style: TextStyle(
                          color: product.inStock ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: QuantityStepper(
                      quantity: product.quantity,
                      onIncrease: onIncrease,
                      onDecrease: onDecrease,
                    )),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: product.quantity == 0 ? () {} : onAddToCart,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: product.quantity == 0
                              ? const Color.fromARGB(255, 235, 184, 145)
                              : AppColors.primaryColor,
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
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    product.supplyBrand,
                    style: TextStyles.bold1(
                        color: AppColors.whiteColor, fontSize: 10),
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
