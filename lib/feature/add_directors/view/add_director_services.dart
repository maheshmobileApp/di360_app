import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/service_model.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_services_foam.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorService extends StatelessWidget with BaseContextHelpers {
  const AddDirectorService({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionHeader('Add Service'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showNewServiceBottomSheet(context);
                  },
                ),
              ],
            ),
            addVertical(16),
            ...addDirectorVM.servicesList.asMap().entries.map((entry) {
              final index = entry.key;
              final service = entry.value;
              return _ServiceCard(context, service, index);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _ServiceCard(BuildContext context, ServiceModel service, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.buttomBarColor,
            backgroundImage: service.imageFile != null
                ? FileImage(service.imageFile!)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: 'Appointment : ',
                    style: TextStyles.medium2(color: AppColors.lightGeryColor),
                    children: [
                      TextSpan(
                        text: service.appointment ? 'Yes' : 'No',
                        style: TextStyles.medium2(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                addVertical(8),
                Text(
                  service.description,
                  style: TextStyles.medium2(color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // const SizedBox(width: 8),
          // GestureDetector(
          //   onTap: () {
          //     Provider.of<AddDirectorViewModel>(context, listen: false)
          //         .Services
          //         .remove(service);
          //   },
          //   child: const Icon(
          //     Icons.delete_outline,
          //     color: AppColors.redColor,
          //     size: 18
          //   ),
          // ),
        ],
      ),
    );
  }

  void showNewServiceBottomSheet(BuildContext context) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.75,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
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
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: AddDirectorServicesFoam(),
                      ),
                    ),
                    CustomBottomButton(
                      onFirst: () => navigationService.goBack(),
                      onSecond: () {
                        addDirectorVM.addService(context);
                        navigationService.goBack();
                      },
                      firstLabel: "Close",
                      secondLabel: "Add",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
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
