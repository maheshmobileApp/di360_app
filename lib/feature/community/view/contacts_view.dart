import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/community/widgets/contact_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ContactsView extends StatefulWidget {
  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
    viewModel.contactsRes = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.selectedFilterContactType = "";
      viewModel.selectedFilterState = "";
      viewModel.getContacts(context);
      viewModel.updateAppliedContactFilter(false);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      viewModel.getContacts(context, loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
     _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final contacts = viewModel.contactsRes?.partnersContactBook;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
          title: "Contacts",
          logo: false,
          searchBarOpen: viewModel.searchBarOpen,
          searchAction: () {
            final isOpening = !viewModel.searchBarOpen;
            viewModel.setSearchBar(isOpening);
            if (isOpening) {
              Future.microtask(() => _searchFocusNode.requestFocus());
            }
          },
          filterWidget: Row(
            children: [
              GestureDetector(
                onTap: () =>
                    navigationService.navigateTo(RouteList.contactFilterView),
                child:
                    SvgPicture.asset(ImageConst.filter, color: AppColors.black),
              ),
              if (viewModel.appliedContactFilter)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () async {
                        viewModel.selectedFilterContactType = "";
                        viewModel.selectedFilterState = "";
                        await viewModel.getContacts(context);
                        viewModel.updateAppliedContactFilter(false);
                      },
                      child: Icon(Icons.close, color: AppColors.black)),
                )
            ],
          )),
      body: Column(
        children: [
          if (viewModel.searchBarOpen)
              SearchWidget(
                focusNode: _searchFocusNode,
                searchButton:
                    viewModel.searchController.text.length >= 3 ? true : false,
                controller: viewModel.searchController,
                hintText: "Search Contacts...",
                onClear: () async {
                  viewModel.searchController.clear();
                  await viewModel.getContacts(context);
                },
                onSearch: () async {
                  _searchFocusNode.unfocus();
                  await viewModel.getContacts(context);
                },
              ),
          (contacts != null && contacts.isNotEmpty)
              ? Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(10),
                    itemCount:
                        contacts.length + (viewModel.hasMoreContacts ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == contacts.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }
                      final contact = contacts[index];
                      return ContactCard(
                          contactName: contact.contactName ?? "",
                          email: contact.email ?? "",
                          phone: contact.phone ?? "",
                          contactType: viewModel.contactTypes.firstWhere(
                                (e) => e["value"] == contact.contactType,
                                orElse: () =>
                                    {"label": contact.contactType ?? ""},
                              )["label"] ??
                              "",
                          state: contact.state ?? "",
                          company: contact.companyName ?? "",
                          onMenuAction: (action) async {
                            switch (action) {
                              case "Edit":
                                navigationService
                                    .navigateTo(RouteList.createContactView);
                                viewModel.setContactDetails(contact);
                                viewModel.setUpdateContactId(contact.id ?? "");
                                viewModel.updateContactEditMode(true);
                                break;
                              case "Delete":
                                showAlertMessage(context,
                                    'Are you sure you want to delete this ${contact.contactName}?',
                                    onBack: () async {
                                  await viewModel.deleteContact(
                                      context, contact.id ?? "");
                                });

                                break;
                            }
                          });
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "No Contacts",
                      style: TextStyles.medium3(
                          color: AppColors.black, fontSize: 16),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: () {
            viewModel.updateContactEditMode(false);
            viewModel.clearContactDetails();
            viewModel.selectedFilterContactType = "";
            viewModel.selectedFilterState = "";
            viewModel.getContacts(context);
            viewModel.updateAppliedContactFilter(false);
            navigationService.navigateTo(RouteList.createContactView);
          },
          child: SvgPicture.asset(ImageConst.createSupport)),
    );
  }

  SizedBox statusWidget(CommunityViewModel communityVM) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: communityVM.statuses.length,
        itemBuilder: (context, index) {
          String status = communityVM.statuses[index];
          bool isSelected = communityVM.selectedStatus == status;
          return GestureDetector(
            onTap: () {
              communityVM.changeStatus(status, context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyles.regular2(
                      color:
                          isSelected ? AppColors.whiteColor : AppColors.black,
                    ),
                  ),
                  SizedBox(width: 6),
                  /*Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "",
                      style: TextStyles.regular2(
                        color:
                            isSelected ? AppColors.black : AppColors.whiteColor,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
