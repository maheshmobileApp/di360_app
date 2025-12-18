import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/support/view/support_messenger_view.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/support/widgets/ticket_card.dart';
import 'package:di360_flutter/feature/support/widgets/upload_image_field.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SupportView extends StatefulWidget {
  @override
  _SupportViewState createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> with ValidationMixins {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<SupportViewModel>(context, listen: false);
      viewModel.setSelectedTab("Open");
      await viewModel.getSupportRequests(context);
      await viewModel.getSupportRequestsReasons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportVM = Provider.of<SupportViewModel>(context);
    final tickets = supportVM.supportRequestsData?.supportRequests ?? [];
    return FutureBuilder<String>(
        future: LocalStorage.getStringVal(LocalStorageConst.type),
        builder: (context, snapshot) {
          final type = snapshot.data ?? '';

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBarWidget(
                title: "Conversations",
                searchAction: () =>
                    supportVM.setSearchBar(!supportVM.searchBarOpen)),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            supportVM.setSelectedTab("Open");
                            supportVM.getSupportRequests(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: supportVM.selectedTab == "Open"
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Open",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: supportVM.selectedTab == "Open"
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // CLOSE TAB
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            supportVM.setSelectedTab("Close");
                            supportVM.getSupportRequests(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: supportVM.selectedTab == "Close"
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: supportVM.selectedTab == "Close"
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: AppColors.geryColor,
                ),
                if (supportVM.searchBarOpen)
                  SearchWidget(
                    controller: supportVM.searchController,
                    hintText: "Enter Ticket Number...",
                    onClear: () {
                      supportVM.searchController.clear();
                      supportVM.getSupportRequests(context);
                    },
                    onSearch: () {
                      supportVM.getSupportRequests(context);
                    },
                  ),
                SizedBox(
                  height: 8,
                ),
                (tickets.length == 0)
                    ? Center(
                        child: SvgPicture.asset(ImageConst.noSupport),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            final ticket = tickets[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TicketCard(
                                userName: (type == "SUPPLIER")
                                    ? ticket.dentalSupplier?.businessName ?? ""
                                    : ticket.dentalProfessional?.name ?? "",
                                ticketNo:
                                    ticket.supportRequestNumber.toString(),
                                dateTime: ticket.createdAt ?? "",
                                reason: ticket.reason ?? "",
                                onTap: () async {
                                  await supportVM
                                      .getSupportMessages(ticket.id ?? "");
                                  navigationService.push(SupportMessengerView(
                                      supportRequest: ticket));
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ]),
            ),
            floatingActionButton: GestureDetector(
                onTap: () {
                  supportVM.getSupportRequestsReasons();
                  supportVM.clearData();
                  showModalBottomSheet(
                    backgroundColor: AppColors.whiteColor,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Raise your Ticket',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                _buildRequestReasons(supportVM),
                                SizedBox(height: 16),
                                InputTextField(
                                  isRequired: true,
                                  controller: supportVM.descriptionController,
                                  hintText: "Enter Message",
                                  title: "Message",
                                  maxLength: 1000,
                                  maxLines: 4,
                                  validator: validateMessage,
                                ),
                                SizedBox(height: 16),
                                UploadImageField(),
                                AppButton(
                                  height: 50,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      supportVM.sendSupportRequest(context);
                                    }
                                  },
                                  text: 'Submit',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(ImageConst.createSupport)),
          );
        });
  }

  Widget _buildRequestReasons(SupportViewModel supportVM) {
    return CustomDropDown(
      isRequired: true,
      value: supportVM.selectedReason,
      title: "Reason Type",
      onChanged: (v) {
        supportVM.setSelectedReason(v as String);
      },
      items: supportVM.requestReasons
          .map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Reason",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select reason'
          : null,
    );
  }
}
