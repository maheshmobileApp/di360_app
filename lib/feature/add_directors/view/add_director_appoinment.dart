import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_appoinment_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorAppoinment extends StatelessWidget with BaseContextHelpers {
  const AddDirectorAppoinment({super.key});
  @override
  Widget build(BuildContext context) {
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
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
                    addDirectorVM.clearTeamMemberList();
                    addDirectorVM.clearServicesList();
                    addDirectorVM.clearDaysList();
                    addDirectorVM.serviceStartTimeCntr.clear();
                    addDirectorVM.serviceEndTimeCntr.clear();
                    addDirectorVM.breakEndTimeCntr.clear();
                    addDirectorVM.breakStartTimeCntr.clear();
                    showAppointmentsBottomSheet(context, editVM);
                  },
                ),
              ],
            ),
            addVertical(16),
            _AppointmentsCard(context, editVM),
          ],
        ),
      ),
    );
  }

  Widget _AppointmentsCard(
      BuildContext context, EditDeleteDirectorViewModel editVM) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: editVM.appointmentsList?.length,
      itemBuilder: (context, index) {
        final apptsData = editVM.appointmentsList?[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.cardcolor,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apptsData?.serviceMember?.join(', ') ?? '',
                        style: TextStyles.bold4(color: AppColors.primaryColor),
                      ),
                      addVertical(5),
                      Text(apptsData?.serviceName?.join(', ') ?? '',
                          style: TextStyles.semiBold(
                              fontSize: 15, color: AppColors.black)),
                      addVertical(5),
                      Text(apptsData?.weekdays?.join(', ') ?? '',
                          style: TextStyles.semiBold(
                              fontSize: 15, color: AppColors.black)),
                      addVertical(5),
                      Text('${apptsData?.durationInMinites ?? ''} min',
                          style: TextStyles.semiBold(
                              fontSize: 15, color: AppColors.black)),
                      addVertical(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: apptsData?.dayWiseTimeslots
                                  ?.map((t) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.13),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              child: Text(t,
                                                  style: TextStyles.medium2(
                                                      color: AppColors
                                                          .primaryColor)),
                                            )),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      )
                    ]),
              ),
              GestureDetector(
                  onTap: () {
                    editVM.deleteAppointment(context, apptsData?.id ?? '');
                  },
                  child: Icon(Icons.delete_outline,
                      color: AppColors.redColor, size: 25)),
            ],
          ),
        );
      },
    );
  }

  void showAppointmentsBottomSheet(
      BuildContext context, EditDeleteDirectorViewModel editVM) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    AddDirectorAppoinmentFoam(),
                    CloseAddButtonWidget(
                      addBtn: () {
                        if (_formKey.currentState!.validate()) {
                          editVM.addAppointment(context);
                          navigationService.goBack();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
