import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class ExpandableHtmlText extends StatelessWidget {
  final String htmlData;
  final dynamic height;
  final int index;

  const ExpandableHtmlText({
    super.key,
    required this.htmlData,
    required this.index,
    this.height = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedViewModel>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: provider.isExpanded(index) ? double.infinity : height,
                ),
                child: ClipRect(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: HtmlWidget(
                      htmlData,
                      renderMode: RenderMode.column,
                      enableCaching: false,
                      customStylesBuilder: (element) {
                        if (element.localName == 'img') {
                          return {'display': 'none'};
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => provider.toggle(index),
              child: Text(
                provider.isExpanded(index) ? "See less" : "See more",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
