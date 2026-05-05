import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class ExpandableHtmlText extends StatefulWidget {
  final String htmlData;
  final dynamic height;
  final int index;

  const ExpandableHtmlText({
    super.key,
    required this.htmlData,
    required this.index,
    this.height = 100.0,
  });

  @override
  State<ExpandableHtmlText> createState() => _ExpandableHtmlTextState();
}

class _ExpandableHtmlTextState extends State<ExpandableHtmlText> {
  final _contentKey = GlobalKey();
  bool _isLengthy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkHeight());
  }

  void _checkHeight() {
    final ctx = _contentKey.currentContext;
    if (ctx == null) return;
    final renderBox = ctx.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final contentHeight = renderBox.size.height;
      if ((contentHeight > widget.height) != _isLengthy) {
        setState(() => _isLengthy = contentHeight > widget.height);
      }
    }
  }

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
                  maxHeight: provider.isExpanded(widget.index) ? double.infinity : widget.height,
                ),
                child: ClipRect(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: HtmlWidget(
                      key: _contentKey,
                      widget.htmlData,
                      renderMode: RenderMode.column,
                      enableCaching: false,
                      customStylesBuilder: (element) {
                        if (element.localName == 'img') {
                          return {'display': 'none'};
                        }
                        return null;
                      },
                      onLoadingBuilder: (_, __, ___) {
                        WidgetsBinding.instance.addPostFrameCallback((_) => _checkHeight());
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (_isLengthy) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => provider.toggle(widget.index),
                child: Text(
                  provider.isExpanded(widget.index) ? "See less" : "See more",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
