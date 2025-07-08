import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/view/catalogue_like_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        if (!_showScrollToTop) {
          setState(() => _showScrollToTop = true);
        }
      } else {
        if (_showScrollToTop) {
          setState(() => _showScrollToTop = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CatalogueViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Banner
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ImageConst.catalogueBg,
                fit: BoxFit.cover,
              ),
            ),
            addVertical(16),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.whiteColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: vm.searchController,
                        onFieldSubmitted: (value) {
                          vm.fetchCatalogue(context);
                        },
                        decoration: InputDecoration(
                          hintText: 'What are you looking for?',
                          hintStyle: TextStyles.dmsansLight(
                              color: AppColors.black, fontSize: 18),
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                if (vm.searchController.text.isNotEmpty) {
                                  await vm.fetchCatalogue(context);
                                  navigationService.goBack();
                                }
                              },
                              child:
                                  Icon(Icons.search, color: AppColors.black)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    addHorizontal(12),
                    GestureDetector(
                      onTap: () => navigationService
                          .navigateTo(RouteList.catalogueFilterScreen),
                      child: CircleAvatar(
                        radius: 23,
                        backgroundColor: AppColors.HINT_COLOR,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.whiteColor,
                          child: SvgPicture.asset(
                            ImageConst.filter,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            addVertical(16),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: vm.catalogueCategories
                      .map((cat) => buildCatalogueSection(context, vm, cat))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
    );
  }

  Widget buildCatalogueSection(
      BuildContext context, CatalogueViewModel vm, CatalogueCategories cat) {
    final showMore = vm.isShowMore(cat.name ?? '');
    final displayList =
        showMore ? cat.catalogues : cat.catalogues?.take(2).toList();
    final expanded = vm.isExpanded(cat.name ?? '');

    return vm.catalogueCategories.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageConst.noCatalogue),
                addVertical(10),
                Text(
                  "No Catalogues",
                  style: TextStyles.medium2(color: AppColors.black),
                ),
              ],
            ),
          )
        : Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVertical(18),

                // Clickable header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: GestureDetector(
                    onTap: () {
                      vm.toggleExpanded(cat.name ?? '');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cat.name ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 19,
                            backgroundColor: Colors.white,
                            child: Icon(
                              expanded ? Icons.remove : Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                addVertical(10),

                if (expanded) ...[
                  Divider(),
                  addVertical(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: GridView.count(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      children: displayList!
                          .map((c) =>
                              buildCatalogueCard(context, vm, c, () async {
                                await vm.getCatalogDetails(context, c.id ?? '');
                                await vm.getReletedCatalog(
                                    context, cat.id ?? '');
                                await navigationService
                                    .navigateTo(RouteList.catalogueDetails);
                              }, displayList))
                          .toList(),
                    ),
                  ),
                  addVertical(12),
                  Divider(),
                  addVertical(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: GestureDetector(
                      onTap: () => vm.toggleShowMore(cat.name ?? ''),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            showMore ? "View Less" : "View More",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            radius: 20,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: Icon(
                                showMore
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  addVertical(10),
                ],
              ],
            ),
          );
  }

  Widget buildCatalogueCard(BuildContext context, CatalogueViewModel vm,
      Catalogues c, Function()? onTap, List<Catalogues>? catalogues) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  c.thumbnailImage?.url ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (ctx, _, __) =>
                      Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.dentalSupplier?.directories?.first.name ?? '',
                          style: TextStyles.regular2(
                              color: AppColors.primaryColor),
                        ),
                        addVertical(5),
                        Text(
                          c.title ?? '',
                          maxLines: 1,
                          style: TextStyles.regular1(color: AppColors.black),
                        )
                      ],
                    ),
                  ),
                  CatalogueLikeWidget(cat: c, catalogues: catalogues),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
