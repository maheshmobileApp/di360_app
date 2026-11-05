import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class SecurePaymentView extends StatelessWidget {
  const SecurePaymentView({super.key});

  static const Color primaryColor = AppColors.primaryColor;
  static const Color textColor = Color(0xFF192235);
  static const Color greyColor = Color(0xFF7C8799);

  Future<void> _handlePayment(
      BuildContext context, MarketPlaceLearningHubViewModel vm) async {
    final clientSecret = vm.courseBookingRes?.clientSecret ?? '';
    if (clientSecret.isEmpty) {
      scaffoldMessenger('Payment session not found. Please try again.');
      return;
    }

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Dental Interface 360',
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      if (context.mounted) {
        navigationService.navigateTo(RouteList.registrationSuccessView);
      }
    } on StripeException catch (e) {
      if (context.mounted) {
        scaffoldMessenger(e.error.localizedMessage ?? 'Payment failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MarketPlaceLearningHubViewModel>(context);
    final totalAmount =
        vm.courseBookingRes?.transaction?.totalAmount?.toDouble() ?? 0.0;
    final formattedAmount = 'A\$${totalAmount.toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: 'Secure Payment'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildAmountCard(formattedAmount),
            ),
            Spacer(),
            _buildBottomButtons(context, vm, formattedAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFE9D9), Color(0xFFFFF7DC)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(13),
            ),
            alignment: Alignment.center,
            child: const Text('🔒', style: TextStyle(fontSize: 25)),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Payment',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textColor),
                ),
                SizedBox(height: 6),
                Text(
                  'Your payment is processed securely via Stripe.',
                  style: TextStyle(fontSize: 13, color: greyColor, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard(String formattedAmount) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFDDC4)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('Amount to pay',
                style: TextStyle(fontSize: 16, color: textColor)),
          ),
          Text(
            formattedAmount,
            style: const TextStyle(
                fontSize: 21, fontWeight: FontWeight.w700, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context,
      MarketPlaceLearningHubViewModel vm, String formattedAmount) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () async {
                await vm.cancelCourse(
                  vm.courseBookingRes?.clientSecret?.split('_secret_').first ??
                      '',
                  vm.courseBookingRes?.transaction?.id ?? '',
                  context,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: textColor,
                minimumSize: const Size(82, 54),
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back', style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () => _handlePayment(context, vm),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Pay $formattedAmount',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
