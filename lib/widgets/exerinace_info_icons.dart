import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ExerinaceInfoIcons extends StatelessWidget {
  final IconData icon;
  final String text;

  const ExerinaceInfoIcons({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: HtmlWidget(
            text,
          ),
        ),
      ],
    );
  }
}
