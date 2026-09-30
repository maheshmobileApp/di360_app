import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/available_options_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/documents_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/product_detail_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/supplies_information_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesViewOptionsDetailView extends StatefulWidget {
  const SuppliesViewOptionsDetailView({super.key});

  @override
  State<SuppliesViewOptionsDetailView> createState() =>
      _SuppliesDetailsViewState();
}

class _SuppliesDetailsViewState extends State<SuppliesViewOptionsDetailView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuppliesViewModel>().getSuppliers(context);
    });

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<SuppliesViewModel>().getSuppliers(
            context,
            isLoadMore: true,
          );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    final suppliesDetails = vm.suppliesDetailsData;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Supplies Details",
            style: TextStyles.bold3(),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio:
                      1.5, // or another value matching your image's aspect ratio
                  child: NetworkImageWidget(
                    imageUrl: suppliesDetails?.image?.first.url ?? '',
                    fit: BoxFit.contain,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                ProductDetailCard(suppliesDetails: suppliesDetails),
                AvailableOptionsCard(suppliesDetails: suppliesDetails),
                _productDescription(suppliesDetails),
                _variantsTable(suppliesDetails?.supplyVariants ?? []),
                DocumentsCard(suppliesDetails: suppliesDetails),
              ],
            )),
      ),
    );
  }
}

_variantsTable(List<SupplyVariants> supplyVariants) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 4),
                Text("Variant Details",
                    style: TextStyles.bold2(color: Colors.black)),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 1),
            Column(
              children: List.generate(
                supplyVariants.length,
                (index) {
                  final variant = supplyVariants[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE6E8EC),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Variant title
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                variant.title ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF344054),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'SKU: ${variant.skuCode?.toString() ?? '-'}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF98A2B3),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Stock
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'STOCK',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF98A2B3),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              variant.availableStock?.toString() ?? '0',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF344054),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 14),

                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'PRICE',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF98A2B3),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '\$${variant.sellingPrice?.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF4D00),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        // Status
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FFF9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (variant.availableStock ?? 0) > 0
                                ? "In Stock"
                                : "Out of stock",
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: (variant.availableStock ?? 0) > 0 ? AppColors.greenColor: AppColors.redColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

_productDescription(Supplies? suppliesDetails) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 4),
                Text("Description",
                    style: TextStyles.bold2(color: Colors.black)),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 1),
            Text(suppliesDetails?.shortInfo ?? "",
                style: TextStyles.medium2(
                  color: Colors.black,
                ))
          ],
        ),
      ),
    ),
  );
}
