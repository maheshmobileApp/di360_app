import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';

class PdfViewWidget extends StatelessWidget
    with BaseContextHelpers {
      final String url;
  final String name;
  const PdfViewWidget({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Document View'),
      body: PdfViewrWidget(fileUrl: url, fileName: name)
    );
  }

  
}
