import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/order_summary_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/product_cart_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRequestReviewView extends StatefulWidget {
  final Map<String, bool> selectedProducts;
  const OrderRequestReviewView({super.key, required this.selectedProducts});

  @override
  State<OrderRequestReviewView> createState() => _OrderRequestReviewViewState();
}

class _OrderRequestReviewViewState extends State<OrderRequestReviewView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    final cartItems = vm.suppliesCartData?.supplyCarts ?? [];

    final proceedItems = cartItems.where((item) {
      return widget.selectedProducts[item.id!] ?? false;
    }).toList();

    final supplier = proceedItems.first.supply?.dentalSupplier?.businessName?? "";
    final itemsCount = proceedItems.length ?? 0;
    final subTotal = proceedItems.fold<double>(
  0,
  (sum, item) =>
      sum + ((item.supplyVariant?.sellingPrice ?? 0) * (item.quantity ?? 0)),
);
final discount = "0.00";
final freightCharges = "0.00";
      

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
              "Order Request Review",
              style: TextStyles.bold3(),
            )),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView(children: [
              ...proceedItems.map((item) {
                return ProductCartCard(
                  checkbox: false,
                  item: item,
                  isSelected: vm.isProductSelected(item.id!),
                  imageUrl: item.supply?.image?.isNotEmpty == true
                      ? item.supply!.image!.first.url ?? ""
                      : "",
                  productId: item.supplyVariant?.skuCode ?? "",
                  productName: item.supply?.name ?? "",
                  price: item.supplyVariant?.sellingPrice?.toString() ?? "",
                  quantity: item.quantity ?? 0,
                  onChecked: (value) {
                    vm.toggleProduct(
                      item,
                      value ?? false,
                    );
                  },
                  onMenuSelected: (action) {},
                );
              }
              
              ),
              SizedBox(height: 10,),
              OrderSummaryCard(supplier: supplier,
              subTotal: subTotal.toString(),discount: discount,itemsCount: itemsCount.toString(),estimatedTotal: subTotal.toString(),freightCharges: freightCharges,)
            ])));
  }
}
