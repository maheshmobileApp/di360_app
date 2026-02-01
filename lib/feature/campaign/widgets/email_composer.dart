import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EmailComposer extends StatefulWidget {
  final TextEditingController toController;
  final TextEditingController subjectController;
  final ValueChanged<String> onBodyChanged;

  const EmailComposer({
    super.key,
    required this.toController,
    required this.subjectController,
    required this.onBodyChanged,
  });

  @override
  State<EmailComposer> createState() => _EmailComposerState();
}

class _EmailComposerState extends State<EmailComposer> {
  late final QuillController _bodyController;

  @override
  void initState() {
    super.initState();
    _bodyController = QuillController.basic();
    _bodyController.addListener(_emitBody);
  }

  void _emitBody() {
    // Get plain text content
    final plainText = _bodyController.document.toPlainText();
    
    // Convert to basic HTML format
    final htmlContent = '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Email</title>
</head>
<body>
<p>${plainText.replaceAll('\n', '</p><p>')}</p>
</body>
</html>''';
    
    widget.onBodyChanged(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TO
        TextField(
          controller: widget.toController,
          decoration: const InputDecoration(
            hintText: 'To',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),

        const Divider(height: 1),

        /// SUBJECT
        TextField(
          controller: widget.subjectController,
          decoration: const InputDecoration(
            hintText: 'Subject',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),

        const Divider(height: 1),

        /// TOOLBAR
        QuillSimpleToolbar(
          controller: _bodyController,
          configurations: const QuillSimpleToolbarConfigurations(),
        ),

        /// BODY
        Container(
          height: 500,
          width: 500,
          child: QuillEditor.basic(
            controller: _bodyController,
            configurations: const QuillEditorConfigurations(
              placeholder: 'Compose email...',
              padding: EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bodyController.removeListener(_emitBody);
    _bodyController.dispose();
    super.dispose();
  }
}