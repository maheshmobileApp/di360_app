import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_details_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/widgets/view_model/supplies_enquiries_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesEnquiriesDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesEnquiriesViewModel>();
    final data = vm.suppliesEnquiriesDetailsData?.supplyEnquiriesByPk;
    return Scaffold(
      appBar: AppBarWidget(
        title: "Supplies Enquiries Details",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _productDetails(data),
          ],
        ),
      ),
    );
  }
}

Widget _productDetails(SupplyEnquiriesByPk? data) {
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
        _textWidget("Product Name", data?.supply?.name ?? ""),
        _textWidget("Brand", data?.supply?.supplyBrand?.name ?? ""),
        _textWidget("Category", data?.supply?.supplyCategory?.name ?? ""),
        _textWidget(
            "Sub Category", data?.supply?.supplySubCategory?.name ?? ""),
        _textWidget("Price",
            data?.supplyVariant?.sellingPrice?.toStringAsFixed(0) ?? ""),
            _image(data?.supply?.image?.firstOrNull?.url?? "")
      ],
    ),
  );
}

Widget _image(String url) {
  return Container(
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
      imageUrl: url,
      fit: BoxFit.contain,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
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
