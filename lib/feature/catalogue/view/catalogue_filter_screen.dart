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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  ImageConst.catalogueBg,
                  fit: BoxFit.cover,
                ),
              ),
              addVertical(16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    addVertical(12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: filterProvider.searchController,
                              onFieldSubmitted: (value) async{
                              await  filterProvider.fetchCatalogue(context);
                                navigationService.goBack();
                              },
                              decoration: InputDecoration(
                                hintText: 'What are you looking for?',
                                hintStyle: TextStyles.dmsansLight(
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                                suffixIcon:
                                    Icon(Icons.search, color: AppColors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          addHorizontal(10),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.black,
                            child: SvgPicture.asset(
                              ImageConst.filter,
                              color: AppColors.whiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    addVertical(12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: filterProvider.filterOptions.isNotEmpty
                          ? Column(
                              children: filterProvider.filterOptions.entries
                                  .map((entry) {
                                final section = entry.key;
                                final items = entry.value;
                                final isVisible =
                                    filterProvider.sectionVisibility[section] ??
                                        true;

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
                                        onTap: () =>
                                            filterProvider.toggleSection(
                                          section,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    if (isVisible)
                                      ...items.asMap().entries.map((item) {
                                        final index = item.key;
                                        final filter = item.value;
                                        final selected = filterProvider
                                                .selectedIndices[section]
                                                ?.contains(index) ??
                                            false;

                                        return CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          value: selected,
                                          activeColor: AppColors.primaryColor,
                                          onChanged: (val) {
                                            filterProvider.selectItem(
                                                section, index);
                                          },
                                          title: Text(
                                            filter.name,
                                            style: TextStyles.regular3(
                                              color: AppColors.lightGeryColor,
                                            ),
                                          ),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        );
                                      }).toList(),
                                    SizedBox(height: 16),
                                  ],
                                );
                              }).toList(),
                            )
                          : Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "No filters available.",
                                  style: TextStyles.regular3(
                                    color: AppColors.lightGeryColor,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                          text: 'Clear',
                          height: 40,
                          width: 150,
                          onTap: () {
                            filterProvider.clearSelections();
                          },
                        ),
                        AppButton(
                          text: 'Apply',
                          height: 40,
                          width: 150,
                          onTap: () {
                            filterProvider.printSelectedItems();
                          },
                        ),
                      ],
                    ),
                    addVertical(10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
