import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DirectoriesFilterScreen extends StatelessWidget with BaseContextHelpers {
  const DirectoriesFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<DirectorViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    ImageConst.catalogueBg,
                    fit: BoxFit.cover,
                  ),
                ),
                addVertical(16),
                buildSearchBar(filterProvider, context),
                //  addVertical(16),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: buildFilters(filterProvider, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    text: 'Clear',
                    height: 40,
                    width: 150,
                    onTap: () async {
                       filterProvider.clearFilter();
                      navigationService.goBack();
                    },
                  ),
                  AppButton(
                    text: 'Apply',
                    height: 40,
                    width: 150,
                    onTap: () async {
                       await filterProvider.getDirectorsList(context);
                      navigationService.goBack();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(
      DirectorViewModel filterProvider, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          addVertical(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                     controller: filterProvider.searchController,
                    onFieldSubmitted: (value) async {
                      await filterProvider.getDirectorsList(context);
                      navigationService.goBack();
                    },
                    decoration: InputDecoration(
                      hintText: 'What are you looking for?',
                      hintStyle: TextStyles.dmsansLight(
                        color: AppColors.black,
                        fontSize: 18,
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () async {
                            if (filterProvider
                                .searchController.text.isNotEmpty) {
                              await filterProvider.getDirectorsList(context);
                              navigationService.goBack();
                            }
                          },
                          child: Icon(Icons.search, color: AppColors.black)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                addHorizontal(10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.black,
                  child: SvgPicture.asset(ImageConst.filter,
                      color: AppColors.whiteColor),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget buildFilters(DirectorViewModel filterProvider, BuildContext context) {
    if (filterProvider.catagoryTypesList!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No filters available.",
            style: TextStyles.regular3(
              color: AppColors.lightGeryColor,
            ),
          ),
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          color: AppColors.whiteColor,
        ),
        child: Column(
          children: filterProvider.catagoryTypesList
              ?.map((type) => Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 24),
                      collapsedBackgroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      childrenPadding: const EdgeInsets.only(bottom: 8),
                      title: Text(
                        type.name ?? '',
                        style: TextStyles.regular3(color: AppColors.black),
                      ),
                      children: type.directoryCategories?.map((category) {
                        final isSelected =
                            filterProvider.selectedCategoryId == category.id;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: isSelected,
                            activeColor: AppColors.primaryColor,
                            onChanged: (val) {
                              filterProvider
                                  .selectSingleCategory(category.id ?? '');
                            },
                            title: Text(
                              category.name ?? '',
                              style: TextStyles.regular3(
                                color: AppColors.lightGeryColor,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  ))
              .toList() ?? [],
        ));
  }
}
