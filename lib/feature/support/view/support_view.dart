import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/support/widgets/ticket_card.dart';
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

class _SupportViewState extends State<SupportView> {
  final List<Map<String, String>> tickets = [
    {
      'userName': 'John Doe',
      'ticketNo': 'DS21001',
      'dateTime': '12 Nov 2025 · 11:45pm',
      'reason':
          'Login issues with the application. Unable to access dashboard after recent update.',
    },
    {
      'userName': 'Jane Smith',
      'ticketNo': 'DS21002',
      'dateTime': '11 Nov 2025 · 09:30am',
      'reason':
          'Payment gateway not working properly. Transaction failed multiple times.',
    },
    {
      'userName': 'Mike Johnson',
      'ticketNo': 'DS21003',
      'dateTime': '10 Nov 2025 · 03:15pm',
      'reason':
          'Profile information not updating correctly. Changes are not being saved.',
    },
  ];
  // default

  @override
  Widget build(BuildContext context) {
    final supportVM = Provider.of<SupportViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        filterWidget: GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
        ),
      ),
      body: (tickets.length == 0)
          ? Center(
              child: SvgPicture.asset(ImageConst.noSupport),
            )
          : Padding(
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
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: TicketCard(
                          userName: ticket['userName']!,
                          ticketNo: ticket['ticketNo']!,
                          dateTime: ticket['dateTime']!,
                          reason: ticket['reason']!,
                          onTap: () {
                            navigationService
                                .navigateTo(RouteList.supportChatScreen);
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
            showModalBottomSheet(
              backgroundColor: AppColors.whiteColor,
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
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
                      SizedBox(height: 20),
                      InputTextField(
                        controller: supportVM.reasonController,
                        hintText: "Enter Reason Type",
                        title: "Reason Type",
                        maxLength: 100,
                        isRequired: true,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter Reason type'
                            : null,
                      ),
                      SizedBox(height: 16),
                      InputTextField(
                        controller: supportVM.courseNameController,
                        hintText: "Enter Description",
                        title: "Description",
                        maxLength: 1000,
                        maxLines: 4,
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        height: 50,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: 'Submit',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: SvgPicture.asset(ImageConst.createSupport)),
    );
  }
}
