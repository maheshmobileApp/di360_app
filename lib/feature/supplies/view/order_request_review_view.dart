import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/delivery_and_notes_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/order_summary_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/payment_mode_card.dart';
import 'package:di360_flutter/feature/supplies/widgets/selected_item_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
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

    final supplier =
        proceedItems.first.supply?.dentalSupplier?.businessName ?? "";
    final itemsCount = proceedItems.length ?? 0;
    final subTotal = proceedItems.fold<double>(
      0,
      (sum, item) =>
          sum +
          ((item.supply?.priceType == "inclusive"
                  ? item.supplyVariant?.sellingPrice ?? 0
                  : item.supplyVariant?.calaculatedPrice ?? 0) *
              (item.quantity ?? 0)),
    );

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
              Card(
                elevation: 2,
                color: AppColors.whiteColor,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    for (var index = 0;
                        index < proceedItems.length;
                        index++) ...[
                      if (index > 0)
                        const Divider(height: 1, indent: 12, endIndent: 12),
                      Builder(
                        builder: (context) {
                          final item = proceedItems[index];
                          return SelectedItemCard(
                              checkbox: false,
                              embedded: true,
                              item: item,
                              isSelected: vm.isProductSelected(item.id!),
                              imageUrl: item.supply?.image?.isNotEmpty == true
                                  ? item.supply!.image!.first.url ?? ""
                                  : "",
                              productId: item.supplyVariant?.skuCode ?? "",
                              productName: item.supply?.name ?? "",
                              price: item.supply?.priceType == "inclusive"
                                  ? item.supplyVariant?.sellingPrice
                                          ?.toString() ??
                                      ""
                                  : item.supplyVariant?.calaculatedPrice
                                          ?.toString() ??
                                      "",
                              quantity: item.quantity ?? 0,
                              onChecked: (value) {
                                vm.toggleProduct(item, value ?? false);
                              },
                              menuOptions: true,
                              onMenuSelected: (value) {
                                switch (value) {
                                  case 'delete':
                                    showAlertMessage(context,
                                        "Are you really want to delete this cart item ?",
                                        no: "No", yes: "Yes", onBack: () async {
                                      await vm.deleteCartItem(
                                          context, item.id ?? "");
                                    });

                                    break;
                                }
                              });
                        },
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DeliveryAndNotesCard(),
              PaymentModeCard(),
              OrderSummaryCard(
                supplier: supplier,
                subTotal: (subTotal - subTotal * 10 / 100).toStringAsFixed(2),
                gst: (subTotal * 10 / 100).toStringAsFixed(2),
                itemsCount: itemsCount.toString(),
                estimatedTotal: subTotal.toString(),
                total: subTotal.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              AppButton(
                  height: 50,
                  title: "Submit Order Request",
                  onPressed: () async {
                    if (vm.checkAddressDetails())
                    if (vm.checkPaymentDetails()) {
                      if (vm.accountPayType == "yes")
                        await vm.addSupplierAccount(context);
                      if (vm.accountPayType == "no")
                        await vm.addSupplierAccountRequest(context);
                      final orderCreated = await vm.addOrder(context);
                      if (orderCreated && context.mounted) {
                        showOrderSuccessPopup(context);
                      }
                    }
                  }),
              SizedBox(
                height: 10,
              ),
            ])));
  }
}

void showOrderSuccessPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.35),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 35, 24, 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success Icon
                  Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFCE2D5),
                        width: 6,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 58,
                      color: Color(0xFFED6A2C),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Title
                  const Text(
                    "Order placed successfully !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF222222),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle
                  const Text(
                    "You can Track Order on My Orders",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFB5B5BE),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Continue Shopping Button
                  SizedBox(
                    height: 50,
                    width: 240,
                    child: ElevatedButton(
                      onPressed: () {
                        navigationService.goBack();
                        navigationService.replaceWith(
                          RouteList.suppliesMarketPlace,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFED6A00),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Continue Shopping",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Close Button
              /*Positioned(
                right: -5,
                top: -12,
                child: IconButton(
                  onPressed: () {
                    navigationService.goBack();
                    navigationService.replaceWith(
                          RouteList.suppliesMarketPlace,
                        );
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFFE91E63),
                    size: 22,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      );
    },
  );
}
