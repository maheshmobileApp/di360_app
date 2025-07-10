import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/model_class/get_releted_catalogue_res.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/feature/catalogue/view/related_catalogue_like_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          onTap: () async {
            await catalogueVM.fetchCatalogue(context);
            navigationService.goBack();
          },
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.black),
        ),
        centerTitle: true,
        title: Text(
          'Catalogue Details',
          style: TextStyles.semiBold(color: AppColors.black, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            addVertical(6),
            SizedBox(
              height: 400,
              child: Card(
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    addVertical(10),
                    SizedBox(
                      height: 330,
                      child: GestureDetector(
                        onTap: () {
                          final pdf =
                              catalogueVM.cataloguesByIdData?.attachment;
                          navigationService.push(HorizantalPdf(
                            key: ValueKey(
                              pdf?.url ?? '',
                            ),
                            fileUrl: pdf?.url ?? '',
                            fileName: pdf?.name ?? '',
                            isfullScreen: true,
                          ));
                        },
                        child: CachedNetworkImageWidget(
                          imageUrl: catalogueVM
                                  .cataloguesByIdData?.thumbnailImage?.url ??
                              '',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final pdf =
                                  catalogueVM.cataloguesByIdData?.attachment;
                              navigationService.push(HorizantalPdf(
                                key: ValueKey(
                                  pdf?.url ?? '',
                                ),
                                fileUrl: pdf?.url ?? '',
                                fileName: pdf?.name ?? '',
                                isfullScreen: true,
                              ));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.remove_red_eye,
                                    color: AppColors.primaryColor),
                                addHorizontal(5),
                                Text('View PDF',
                                    style: TextStyles.regular4(
                                        color: AppColors.black)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final url = catalogueVM
                                      .cataloguesByIdData?.attachment?.url ??
                                  '';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(Icons.download_rounded,
                                      size: 16, color: AppColors.whiteColor),
                                ),
                                addHorizontal(8),
                                Text('DOWNLOAD CATALOGUE',
                                    style: TextStyles.regular1(
                                        color: AppColors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVertical(10),
                  ],
                ),
              ),
            ),
            buildCatalogueSection(context, catalogueVM),
          ],
        ),
      ),
    );
  }

  Widget buildCatalogueSection(BuildContext context, CatalogueViewModel vm) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVertical(16),
          Center(
            child: Text('RELATED CATALOGUES',
                style: TextStyles.bold1(color: AppColors.black, fontSize: 16)),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: vm.reletedCatalogues
                        ?.map((c) => buildCatalogueCard(context, c, vm))
                        .toList() ??
                    [],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCatalogueCard(
      BuildContext context, CatalogData catalogues, CatalogueViewModel vm) {
    return GestureDetector(
      onTap: () async {
        await vm.getCatalogDetails(context, catalogues.id ?? '');
      },
      child: Container(
        padding: EdgeInsets.only(right: 15),
        height: 250,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.hintColor, width: 10)),
                  child: Image.network(
                    catalogues.thumbnailImage?.url ?? '',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder: (ctx, _, __) =>
                        Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 45,
                      child: Text(catalogues.title ?? '',
                          style: TextStyles.regular2(color: AppColors.black)),
                    ),
                  ),
                  RelatedCatalogueLikeWidget(cat: catalogues),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
