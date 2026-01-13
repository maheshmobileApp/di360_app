import 'dart:convert';

import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Reusable, enterprise-safe Email Composer (Unlayer)
/// Verified dependency: webview_flutter (flutter.dev)
class HtmlEmailComposer extends StatefulWidget {
  final TextEditingController subjectController;
  final CampaignViewModel viewModel;
  final void Function(String subject, String html, Map<String, dynamic> design)?
      onChange;
  final Map<String, dynamic>? initialDesign;

  const HtmlEmailComposer({
    super.key,
    required this.subjectController,
    this.onChange,
    this.initialDesign, required this.viewModel,
  });

  @override
  State<HtmlEmailComposer> createState() => _HtmlEmailComposerState();
}

class _HtmlEmailComposerState extends State<HtmlEmailComposer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message) {
          final data = jsonDecode(message.message);

          widget.onChange?.call(
            widget.subjectController.text.trim(),
            data['html'],
            data['design'],
          );
        },
      )
      ..loadHtmlString(_unlayerHtml(widget.initialDesign));
  }

  /// Call this when you want to export HTML + JSON
  Future<void> exportEmail() async {
    await _controller.runJavaScript('exportEmail()');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyLight),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Compose",
            style: TextStyles.regular3(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          InputTextField(
            controller: widget.subjectController,
            hintText: "Email Subject",
            title: "",
            maxLength: 100,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }

  String _unlayerHtml(Map<String, dynamic>? initialDesign) => '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://editor.unlayer.com/embed.js"></script>
<style>
  body, html {
    margin: 0;
    height: 100%;
  }
</style>
</head>
<body>

<div id="editor" style="height:100%;"></div>

<script>
  unlayer.init({
    id: 'editor',
    displayMode: 'email',
    callbacks: {
      onDesignLoad: function(data) {
        exportEmail();
      },
      onLoad: function() {
        exportEmail();
      },
      onDesignUpdated: function(data) {
        exportEmail();
      }
    }
  });

  ${initialDesign != null ? '''
  unlayer.loadDesign(${jsonEncode(initialDesign)});
  ''' : ''}

  function exportEmail() {
    unlayer.exportHtml(function(data) {
      window.FlutterChannel.postMessage(JSON.stringify({
        html: data.html,
        design: data.design
      }));
    });
  }
  
  // Export triggered by editor callbacks only
</script>

</body>
</html>
''';
}
