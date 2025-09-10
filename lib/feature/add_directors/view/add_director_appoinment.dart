import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_appoinment_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDirectorAppoinment extends StatelessWidget with BaseContextHelpers {
  const AddDirectorAppoinment({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Appointments'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showAppointmentsBottomSheet(context);
                  },
                ),
              ],
            ),
            addVertical(16),
            _AppointmentsCard(),
          ],
        ),
      ),
    );
  }

  Widget _AppointmentsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 247, 249, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
           CircleAvatar(
            radius: 20,
            child: SvgPicture.asset(ImageConst.accountProfile),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User name',
                  style: TextStyles.semiBold(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Designation',
                  style: TextStyles.regular1(
                    fontSize: 12,
                    color: AppColors.bottomBarSelectIconColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, size: 20),
        ],
      ),
    );
  }

  void showAppointmentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: AddDirectorAppoinmentFoam(),
                      ),
                    ),
                    CloseAddButtonWidget()
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
