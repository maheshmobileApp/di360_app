import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogueDetailsScreen extends StatelessWidget with BaseContextHelpers {
  const CatalogueDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalogueVM = Provider.of<CatalogueViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.buttomBarColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: GestureDetector(
          onTap: () => navigationService.goBack(),
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.black),
        ),
        centerTitle: true,
        title: Text(
          'Catalogue Details',
          style: TextStyles.semiBold(color: AppColors.black, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: Card(
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: HorizantalPdf(
                          key: ValueKey(
                            catalogueVM.cataloguesByIdData?.attachment?.url ?? '',
                          ),
                          fileUrl: catalogueVM.cataloguesByIdData?.attachment?.url ?? '',
                          fileName: '',
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.download_rounded,
                                color: AppColors.whiteColor),
                          ),
                          Text('DOWNLOAD CATALOGUE',
                              style: TextStyles.regular1(color: AppColors.black)),
                        ],
                      ),
                    ),
                    addVertical(10),
                  ],
                ),
              ),
            ),
            Expanded(child: buildCatalogueSection(context, catalogueVM)),
          ],
        ),
      ),
    );
  }

  Widget buildCatalogueSection(BuildContext context, CatalogueViewModel vm) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVertical(18),
            Center(
              child: Text(
                'RELATED CATALOGUES',
                style: TextStyles.regular1(color: AppColors.black),
              ),
            ),
            addVertical(10),
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
                children: vm.reletedCatalogues
                        ?.map((c) => buildCatalogueCard(context, c, vm))
                        .toList() ??
                    [],
              ),
            ),
            addVertical(10),
          ],
        ),
      ),
    );
  }

  Widget buildCatalogueCard(
      BuildContext context, CatalogData catalogues, CatalogueViewModel vm) {
    return GestureDetector(
      onTap: () async {
        await vm.getCatalogDetails(context, catalogues.id ?? '');
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  catalogues.thumbnailImage?.url ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (ctx, _, __) =>
                      Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(catalogues.title ?? '',
                  style: TextStyles.regular2(color: AppColors.black)),
            )
          ],
        ),
      ),
    );
  }
}
