import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/widgets/app_button.dart';

class CatalogueFilterScreen extends StatelessWidget with BaseContextHelpers {
  const CatalogueFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<CatalogueViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(ImageConst.catalogueBg,
                            fit: BoxFit.cover)),
                            Positioned(
                              left: 10,top: 20,
                              child: InkWell(
                                onTap: () => navigationService.goBack(),
                              child: CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.arrow_back,color: AppColors.black)),
                            ))
                  ],
                ),
                addVertical(16),
                buildSearchBar(filterProvider, context),
                //  addVertical(16),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: buildFilters(filterProvider),
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
                      filterProvider.clearSelections(context);
                      navigationService.goBack();
                    },
                  ),
                  AppButton(
                    text: 'Apply',
                    height: 40,
                    width: 150,
                    onTap: () async {
                      filterProvider.printSelectedItems();
                      await filterProvider.fetchCatalogue(context);
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
      CatalogueViewModel filterProvider, BuildContext context) {
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
                      await filterProvider.fetchCatalogue(context);
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
                              await filterProvider.fetchCatalogue(context);
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

  Widget buildFilters(CatalogueViewModel filterProvider) {
    if (filterProvider.filterOptions.isEmpty) {
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
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: filterProvider.filterOptions.entries.map((entry) {
            final section = entry.key;
            final items = entry.value;
            final isVisible = filterProvider.sectionVisibility[section] ?? true;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  minTileHeight: 30,
                  minVerticalPadding: 0,
                  title: Text(
                    'Filter by $section',
                    style: TextStyles.regular3(
                      color: AppColors.black,
                    ),
                  ),
                  trailing: InkWell(
                    child: Icon(
                      isVisible
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onTap: () => filterProvider.toggleSection(section),
                  ),
                ),
                Divider(),
                if (isVisible)
                  ...items.asMap().entries.map((item) {
                    final index = item.key;
                    final filter = item.value;
                    final selected = filterProvider.selectedIndices[section]
                            ?.contains(index) ??
                        false;

                    return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: selected,
                        activeColor: AppColors.primaryColor,
                        onChanged: (val) {
                          filterProvider.selectItem(section, index);
                        },
                        title: Text(
                          filter.name,
                          style: TextStyles.regular3(
                              color: AppColors.lightGeryColor),
                        ),
                        controlAffinity: ListTileControlAffinity.leading);
                  }).toList(),
                SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
