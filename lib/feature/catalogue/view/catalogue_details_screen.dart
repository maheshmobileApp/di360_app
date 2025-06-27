import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/catalogue/view/horizantal_pdf.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CatalogueDetailsScreen extends StatefulWidget {
  const CatalogueDetailsScreen({super.key});

  @override
  State<CatalogueDetailsScreen> createState() => _CatalogueDetailsScreenState();
}

class _CatalogueDetailsScreenState extends State<CatalogueDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final catalogueVM = Provider.of<CatalogueViewModel>(context);
    final pdfUrl =
        catalogueVM.cataloguesByIdData?.attachment?.url ?? '';

    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: 8, // Example: 8 pages
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: HorizantalPdfViewerScreen(
                            fileUrl: pdfUrl,
                            fileName: '',
                          //  pageNumber: index + 1,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 8,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: AppColors.black),
                        onPressed: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios,
                            color: AppColors.black),
                        onPressed: () {
                          if (_currentPage < 7) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 8,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // handle download logic
              },
              icon: Icon(Icons.download),
              label: Text(
                "Download Catalogue",
                style: TextStyles.medium3(
                  color: AppColors.whiteColor,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
