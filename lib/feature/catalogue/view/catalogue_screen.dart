import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_catalogue_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatelessWidget with BaseContextHelpers {
  const CataloguePage({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CatalogueViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(ImageConst.catalogueBg, fit: BoxFit.cover),
          ),
          addVertical(16),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'What are you looking for?',
                          hintStyle: TextStyles.dmsansLight(
                              color: AppColors.black, fontSize: 18),
                          suffixIcon:
                              Icon(Icons.search, color: AppColors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  addHorizontal(12),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.HINT_COLOR,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.whiteColor,
                      child: SvgPicture.asset(ImageConst.filter,
                          color: AppColors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          addVertical(15),
          ...vm.catalogueCategories
              .map((cat) => buildCatalogueSection(context, vm, cat))
              .toList(),
        ],
      ),
    );
  }

  Widget buildCatalogueSection(
      BuildContext context, CatalogueViewModel vm, CatalogueCategories cat) {
    final showMore = vm.isShowMore(cat.name ?? '');
    final displayList =
        showMore ? cat.catalogues : cat.catalogues?.take(2).toList();

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
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
                    child: Icon(Icons.add, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: GridView.count(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              children: displayList!
                  .map((c) => buildCatalogueCard(context, vm, c))
                  .toList(),
            ),
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 5),
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
                        color: Colors.black),
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
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildCatalogueCard(
      BuildContext context, CatalogueViewModel vm, Catalogues c) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () async {
          await vm.getCatalogDetails(context, c.id ?? '');
          await navigationService.navigateTo(RouteList.catalogueDetails);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.title ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    c.dentalSupplier?.directories?.first.name ?? '',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
