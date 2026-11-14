import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentRequiredPopup extends StatelessWidget {
  const PaymentRequiredPopup({
    super.key,
    this.title,
    this.message,
  });

  final String? title;
  final String? message;

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PaymentRequiredPopup(
          title: "Complete Your Subscription",
          message:
              "Your mobile experience awaits! Make your payment on our web app and you’re ready to go. Happy exploring!",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final addDirectoryVM =
      Provider.of<AddDirectoryViewModel>(context, listen: false);
  final viewProfileVM =
      Provider.of<ViewProfileViewModel>(context, listen: false);
  final professionalAddDirVM =
      Provider.of<ProfessionalAddDirectorVm>(context, listen: false);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 28, 12, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF4E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.event,
                size: 30,
                color: Color(0xFFFF7A00),
              ),
            ),

            const SizedBox(height: 28),

            // Title
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyles.bold3(),
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: TextStyles.medium2(),
            ),

            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () async {
                       await Loaders.circularShowLoader(context);
                  await deleteToken();
                  await LocalStorage.clearAllData();
                  addDirectoryVM.clearAllDirectorData();
                  viewProfileVM.clearProfileData();
                  professionalAddDirVM.clearProfessionalDirectorData();
                  await Loaders.circularHideLoader(context);
                  navigationService.pushNamedAndRemoveUntil(RouteList.login);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF8F8F8),
                        side: const BorderSide(
                          color: Color(0xFFE0E0E0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "logout",
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF555555),
                        ),
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
