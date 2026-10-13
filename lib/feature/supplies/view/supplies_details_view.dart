import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/documents_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/product_detail_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/supplies_information_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesDetailsView extends StatefulWidget {
  const SuppliesDetailsView({super.key});

  @override
  State<SuppliesDetailsView> createState() => _SuppliesDetailsViewState();
}

class _SuppliesDetailsViewState extends State<SuppliesDetailsView> {
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
                _productDetails(suppliesDetails),
                SuppliesInformationCard(suppliesDetails: suppliesDetails),
                DocumentsCard(suppliesDetails: suppliesDetails),
              ],
            )),
      ),
    );
  }
}

_productDetails(Supplies? suppliesDetails) {
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
                Icon(Icons.description, size: 18, color: AppColors.primaryColor),
                const SizedBox(width: 4),
                Text("PRODUCT DETAILS",
                    style: TextStyles.bold2(color: Colors.black)),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 1),
            Text(suppliesDetails?.shortInfo ?? "", style: TextStyles.medium2(color: Colors.black,))
          ],
        ),
      ),
    ),
  );
}
