import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supllies_module/model/supplies_detail_res.dart';
import 'package:di360_flutter/feature/supllies_module/view_model/supplies_module_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesModuleViewModel>();
    final data = vm.suppliesDetailData?.suppliesByPk;
    final variants = data?.supplyVariants ?? [];
    return Scaffold(
      appBar: AppBarWidget(
        title: "Product Detail View",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _productDetails(data),
            ...variants.map(_variantDetails),
            _description(data)
          ],
        ),
      ),
    );
  }
}

Widget _productDetails(SuppliesByPk? data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("1. Product Details",
            style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        _textWidget("Product Name", data?.name ?? ""),
        _textWidget("Brand Name", data?.supplyBrand?.name ?? ""),
        _textWidget("Category", data?.supplyCategory?.name ?? ""),
        _textWidget("Sub Category", data?.supplySubCategory?.name ?? "")
      ],
    ),
  );
}

Widget _description(SuppliesByPk? data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("2. Description", style: TextStyles.clashSemiBold(fontSize: 16)),
        const SizedBox(height: 10),
        _textWidget("Short Description", data?.shortInfo ?? ""),
        _textWidget("Specifications", data?.specifications ?? "NA"),
        const SizedBox(height: 10),
        Text("Seo Details",
            style: TextStyles.clashSemiBold(
                fontSize: 14, color: AppColors.primaryColor)),
        const SizedBox(height: 10),
        _textWidget("Title", data?.seoMetadata?.title ?? "NA"),
        _textWidget("Keywords", data?.seoMetadata?.keywords ?? "NA"),
        _textWidget("Image", data?.seoMetadata?.image ?? "NA"),
        _textWidget("Description", data?.seoMetadata?.description ?? "NA")
      ],
    ),
  );
}

Widget _variantDetails(SupplyVariants? data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textWidget("Variant", data?.title ?? ""),
          _textWidget("Colors", data?.color ?? "NA"),
          _textWidget("Actual Price", data?.actualPrice.toString() ?? "NA"),
          _textWidget("Selling Price", data?.sellingPrice.toString() ?? "NA"),
          _textWidget(
              "Available Stock", data?.availableStock.toString() ?? "NA"),
          _textWidget("Sku Code", data?.skuCode ?? "NA"),
          _textWidget("More Images", data?.moreImages ?? "NA"),
          _textWidget("Video", data?.video ?? "NA"),
        ],
      ),
    ),
  );
}

Widget _textWidget(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF828181),
            ),
          ),
        ),
        const Text(
          " : ",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828181),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
