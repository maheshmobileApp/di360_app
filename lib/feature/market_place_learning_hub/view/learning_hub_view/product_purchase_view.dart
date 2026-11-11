import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/widgets/promo_code_field.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPurchaseView extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String courseName;
  final String courseType;
  final String courseId;
  final double coursePrice;
  final double discount;
  final VoidCallback? onEdit;
  final VoidCallback? onCompleteRegistration;

  const ReviewPurchaseView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.courseName,
    required this.courseType,
    required this.courseId,
    required this.coursePrice,
    required this.discount,
    this.onEdit,
    this.onCompleteRegistration,
  });

  static const Color primaryColor = Color(0xFFFF7000);
  static const Color textColor = Color(0xFF192235);
  static const Color greyColor = Color(0xFF7C8799);

  @override
  State<ReviewPurchaseView> createState() => _ReviewPurchaseViewState();
}

class _ReviewPurchaseViewState extends State<ReviewPurchaseView> {
  double get totalAmount => widget.coursePrice - widget.discount;

  String formatPrice(double value,MarketPlaceLearningHubViewModel vm) {
    return value == 0 ? "Free" : vm.promoCodeRes?.promoId != null? "A\$${vm.promoCodeRes?.finalPrice?.toStringAsFixed(2)}": "A\$${value.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MarketPlaceLearningHubViewModel>(context);
    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: 'Purchase Review'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildUserInformation(),
            _buildCourseSummary(vm),
            _buildBottomButton(vm, widget.courseId),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFE9D9),
            Color(0xFFFFF7DC),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: ReviewPurchaseView.primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text(
                "🎓",
                style: TextStyle(fontSize: 27),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Review & Complete Your Purchase",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ReviewPurchaseView.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Please review your details and proceed "
                  "with the payment.",
                  style: TextStyle(
                    fontSize: 14,
                    color: ReviewPurchaseView.greyColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildUserInformation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFDDC4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Color(0xFF563184),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Your Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF455064),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigationService.goBack();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 14,
                        color: Color(0xFFE76600),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Edit",
                        style: TextStyle(
                          color: Color(0xFFE76600),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoItem("First Name", widget.firstName),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoItem("Last Name", widget.lastName),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoItem("Mobile Number", widget.mobile),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _infoItem("Email Address", widget.email),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: ReviewPurchaseView.greyColor,
            fontSize: 14,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ReviewPurchaseView.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseSummary(MarketPlaceLearningHubViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E5EB),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ReviewPurchaseView.textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0E5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.courseType,
                            style: TextStyle(
                              color: Color(0xFFD95E00),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      if (vm.promoCodeRes?.promoId != null)
                      Text(
                        "A\$${totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ReviewPurchaseView.greyColor,
                        ),
                      ),
                      Text(
                        formatPrice(totalAmount, vm),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ReviewPurchaseView.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (vm.checkCourseRes?.isFree == false)
              PromoCodeField(
                controller: vm.promoCodeController,
                onApply: (String p1) async {
                  await vm.applyPromoCode(context, widget.courseId);
                },
              ),
            const Divider(
              height: 1,
              color: Color(0xFFEAECF0),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  _priceRow(
                    "Course Price",
                    "A\$${widget.coursePrice.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 16),
                  _priceRow(
                    "Discount",vm.promoCodeRes?.promoId != null? "- A\$${vm.promoCodeRes?.discountAmount?.toStringAsFixed(2)}":
                    "- A\$${widget.discount.toStringAsFixed(2)}",
                    valueColor: const Color(0xFF15956C),
                  ),
                  const SizedBox(height: 14),
                  const Divider(
                    color: Color(0xFFEAECF0),
                  ),
                  const SizedBox(height: 10),
                  _priceRow(
                    "Total Amount",
                    formatPrice(totalAmount, vm),
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(
    String title,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal
                  ? ReviewPurchaseView.textColor
                  : ReviewPurchaseView.greyColor,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: valueColor ??
                (isTotal
                    ? ReviewPurchaseView.textColor
                    : ReviewPurchaseView.greyColor),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(
      MarketPlaceLearningHubViewModel vm, String courseId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await vm.courseBooking(courseId, context);
          
        },
        child: SizedBox(
            height: 50,
            child: AppButton(
              text: formatPrice(totalAmount, vm) == "Free"
                  ? "Complete Registration"
                  : "Buy now",
            )),
      ),
    );
  }
}
