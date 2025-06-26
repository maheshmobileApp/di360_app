import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CataloguePage extends StatefulWidget {
  @override
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> with BaseContextHelpers {
  bool showMore = false;

  // Sample dummy data (can be replaced with API or JSON)
  final List<Map<String, String>> catalogues = List.generate(6, (index) {
    return {
      "title": "SMILE TECH",
      "subtitle": "Schrack Catalogue",
      "image":
          "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/7c0f8164-065e-49aa-b568-3d4774b0d450",
    };
  });

  @override
  Widget build(BuildContext context) {
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

          // Sections
          catalogueSection("ALL CATALOGUES"),
          const SizedBox(height: 24),
          catalogueSection("PROMOTIONAL"),
        ],
      ),
    );
  }

  Widget catalogueSection(String title) {
    // Control how many items to show
    final displayList = showMore ? catalogues : catalogues.take(2).toList();

    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVertical(18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyles.regular3(color: AppColors.black)),
                CircleAvatar(
                  backgroundColor: AppColors.buttomBarColor,
                  radius: 20,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: AppColors.whiteColor,
                    child: Icon(
                      Icons.add,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          addVertical(5),
          Divider(),
          addVertical(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 0,
              childAspectRatio: 0.55,
              children:
                  displayList.map((item) => buildCatalogueCard(item)).toList(),
            ),
          ),
          addVertical(12),
          Divider(),
          addVertical(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: GestureDetector(
              onTap: () => setState(() {
                showMore = !showMore;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(showMore ? "View Less" : "View More",
                      style: TextStyles.regular3(color: AppColors.black)),
                  CircleAvatar(
                    backgroundColor: AppColors.buttomBarColor,
                    radius: 20,
                    child: CircleAvatar(
                      radius: 19,
                      backgroundColor: AppColors.whiteColor,
                      child: Icon(
                          showMore
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          addVertical(10)
        ],
      ),
    );
  }

  Widget buildCatalogueCard(Map<String, String> item) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(item["image"]!,
                  fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["title"]!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item["subtitle"]!, style: TextStyle(fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
